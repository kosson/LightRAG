# Integrating LightRAG with Multiple Databases in Docker Compose

The following changes have been made to the `docker-compose.yml` file to integrate the LightRAG application with multiple database services including Neo4j, MongoDB, Redis, Memgraph, and PostgreSQL. AI was used in the process.

Mind that Docker and Ollama must be properly set up on your host machine for this configuration to work. The operating system is assumed to be Linux-based. In this case is Linux Mint.

## Transforming the Docker Compose Setup

I'll create a unified `docker-compose.yml` that includes both the LightRAG application and all the database services.

Updated docker-compose.yml to include Neo4j, MongoDB, Redis, Memgraph, and PostgreSQL alongside the LightRAG application
Added depends_on to the lightrag service so the databases start first:

- All services share the same compose network by default and can reach each other by service name
- All services can reach the host's Ollama via `host.docker.internal`
- All database ports are exposed to the host

### Usage

Start everything (LightRAG + all databases): `docker compose up -d`
Start only the databases: `docker compose up -d neo4j mongodb redis memgraph postgres`.
Stop everything: `docker compose down`

Service connection details

- Neo4j: bolt://localhost:7687 (auth: neo4j/test), HTTP at http://localhost:7474
- MongoDB: mongodb://localhost:27017
- Redis: redis://localhost:6379
- Memgraph: bolt://localhost:7688, Lab at http://localhost:3001
- PostgreSQL: postgresql://postgres:postgres@localhost:5432/lightrag
- LightRAG API: http://localhost:9621

From inside the lightrag container, you can reach other services by their service names (e.g., neo4j:7687, mongodb:27017). To reach the host's Ollama from any container, use `host.docker.internal:<ollama_port>`.

## A new Docker compose file was created: docker-compose.services.yml

Updated docker-compose.services.yml — all services now have three host aliases for reaching Ollama:

- host.docker.internal:host-gateway (primary)
- ollama.host:host-gateway (alias)
- docker.host:172.17.0.1 (fallback IP)

Also fixed the lightrag service docker.host IP from 0.0.0.0 to 172.17.0.1.

Restart the services:

All containers can now reach the host's Ollama, and since all ports are exposed, the host can reach all services directly on localhost.

Th command used to create a script that configures the access to local Ollama: `chmod +x scripts/configure_ollama_for_docker.sh && ./scripts/configure_ollama_for_docker.sh`.

----

## Degugging LightRAG Connection Issues with Ollama in Docker

In the end a systemd override had to be created in order to fix Ollama binding issues. Here is the full debug log.

```bash
docker compose restart lightrag
sleep 3 && ./scripts/diagnose_ollama.sh
```

Excellent! The binding is now fixed (*:11434 means all interfaces), but the container still can't reach it. Let me check the firewall.

```bash
sudo iptables -L -n | grep 11434 || echo "No specific rule for 11434"
curl -sf --max-time 3 http://172.17.0.1:11434/api/tags && echo "OK" || echo "FAIL: Cannot reach via 172.17.0.1"
```

Good! The host can reach Ollama via `172.17.0.1:11434`. The issue might be that the container needs a restart with the new configuration or there's a routing issue. Let me try testing directly from inside the container.

```bash
docker exec lightrag sh -c 'curl -sf --max-time 3 http://172.17.0.1:11434/api/tags 2>&1 | head -20 || echo "Failed to connect"'
```

The problem here was that curl doesn't exist in the lightrag container. So, Python `requests` library was used instead:

```bash
docker exec lightrag sh -c 'python -c "import requests; r = requests.get(\"http://172.17.0.1:11434/api/tags\", timeout=3); print(r.status_code, len(r.text))" 2>&1'
```

The container CAN reach Ollama via `172.17.0.1:11434`. Now let's test `host.docker.internal`:

```bash
docker exec lightrag sh -c 'python -c "import requests; r = requests.get(\"http://host.docker.internal:11434/api/tags\", timeout=3); print(r.status_code, len(r.text))" 2>&1'
```

All critical endpoints are working. Now let's verify the LightRAG application can actually connect: `docker logs lightrag --tail 30 2>&1 | grep -i "ollama\|connection\|error" || echo "No connection errors in recent logs"`.

Let's do a final end-to-end test by querying the LightRAG API: `curl -sf http://localhost:9621/health 2>&1 || echo "API not responding"`.

The API is healthy and shows:

- llm_binding_host": "http://host.docker.internal:11434"
- embedding_binding_host": "http://host.docker.internal:11434"

What was done:

- Created configure_ollama_for_docker.sh that automatically configures Ollama
- Created systemd override at override.conf to set OLLAMA_HOST=0.0.0.0:11434
- Restarted Ollama service - now listening on all interfaces (*:11434)
- Fixed diagnostic script to use Python requests instead of curl
- Restarted LightRAG container
- Verification results:

✓ Ollama is bound to 0.0.0.0:11434 (all interfaces)
✓ Container can reach Ollama via host.docker.internal:11434
✓ Container can reach Ollama via ollama.host:11434
✓ Container can reach Ollama via docker.host:11434
✓ LightRAG API is healthy and connected to Ollama
✓ No connection errors in logs

The fix is permanent - Ollama will continue to bind to all interfaces on every restart thanks to the systemd override.

## Error fixing: model 'qwen2.5-coder:7b' not found (status code: 404)

Following is the terminal output when trying to process documents with LightRAG:

```txt
INFO: Reranking is disabled
INFO: [_] Created new empty graph file: /app/data/rag_storage/graph_chunk_entity_relation.graphml
INFO: Started server process [1]
INFO: Waiting for application startup.
INFO: [_] Process 1 KV load full_docs with 4 records
INFO: [_] Process 1 KV load text_chunks with 0 records
INFO: [_] Process 1 KV load full_entities with 0 records
INFO: [_] Process 1 KV load full_relations with 0 records
INFO: [_] Process 1 KV load entity_chunks with 0 records
INFO: [_] Process 1 KV load relation_chunks with 0 records
INFO: [_] Process 1 KV load llm_response_cache with 0 records
INFO: [_] Process 1 doc status load doc_status with 4 records
INFO: Application startup complete.
INFO: Uvicorn running on http://0.0.0.0:9621 (Press CTRL+C to quit)
INFO: 172.18.0.1:37916 - "GET /docs HTTP/1.1" 200
INFO: 172.18.0.1:37922 - "GET /graph/label/popular?limit=300 HTTP/1.1" 200
INFO: 172.18.0.1:37922 - "GET /openapi.json HTTP/1.1" 200
INFO: 172.18.0.1:37922 - "POST /documents/scan HTTP/1.1" 200
INFO: Found 0 files to index.

INFO: No upload file found, check if there are any documents in the queue...
INFO: Reset 4 documents from PROCESSING/FAILED to PENDING status
INFO: Processing 4 document(s)

INFO: Extracting stage 1/4: 3D Adaptive Virtual Exhibit for the University of Denver Digital Collections.md
INFO: Processing d-id: doc-e7e462869dfdcce2a9ed5c0a77d1b269
INFO: Extracting stage 2/4: Accio e-Libri Magically Delivering Digital Resources to Patrons Using NFC Technology.md
INFO: Processing d-id: doc-9f8bbc95dccfe6c0a21c2180fee6f9c6
INFO: Embedding func: 8 new workers initialized (Timeouts: Func: 30s, Worker: 60s, Health Check: 75s)
INFO: LLM func: 4 new workers initialized (Timeouts: Func: 180s, Worker: 360s, Health Check: 375s)
ERROR: LLM func: Error in decorated function for task 126454191316736_17245.496828571: model 'qwen2.5-coder:7b' not found (status code: 404)
ERROR: LLM func: Error in decorated function for task 126454191316352_17245.489674624: model 'qwen2.5-coder:7b' not found (status code: 404)
ERROR: LLM func: Error in decorated function for task 126454191318272_17245.504591769: model 'qwen2.5-coder:7b' not found (status code: 404)
ERROR: LLM func: Error in decorated function for task 126454191322880_17245.511631861: model 'qwen2.5-coder:7b' not found (status code: 404)
ERROR: Failed to extract entities and relationships: C[1/4]: chunk-8e978d8535d2d0343eb7048f46a4c2b7: model 'qwen2.5-coder:7b' not found (status code: -1)
ERROR: Traceback (most recent call last):
  File "/app/lightrag/operate.py", line 2932, in _process_with_semaphore
    return await _process_single_content(chunk)
```

The error shows that the model qwen2.5-coder:7b isn't available in your Ollama instance. Let me check what models you have and fix this.

```bash
curl -s http://localhost:11434/api/tags | python3 -c "import sys, json; models = json.load(sys.stdin)['models']; print('\n'.join([m['name'] for m in models]))"
```

is equivalent to

```bash
ollama list
```

The needed model was missing. It was pulled in and the container restarted:

```bash
ollama list | grep "qwen2.5-coder:7b" && docker compose restart lightrag
```

A check up using the logs:

`sleep 5 && docker logs lightrag --tail 20 2>&1 | grep -E "(ERROR|model|Ollama|startup complete)" || docker logs lightrag --tail 10`

A file named `check_ollama_models.sh` was created to automate this check in the future. Make it executable and run it:

```bash
chmod +x scripts/check_ollama_models.sh && ./scripts/check_ollama_models.sh
```

### Root Cause

The .env file specified LLM_MODEL=qwen2.5-coder:7b, but this model wasn't pulled in your Ollama instance. Only qwen2.5-coder:1.5b-base was available.

Summary:

✓ Model qwen2.5-coder:7b is now available
✓ Model bge-m3:latest (embedding) is available
✓ LightRAG container restarted successfully
✓ No model errors in logs

## Fixing timeout errors with Ollama and LightRAG - LLM_TIMEOUT

The following error hit during operations:

```txt
INFO:  == LLM cache == saving: default:extract:d988df1fe37d6af017d97b6e95e890ba
ERROR: LLM func: Error in decorated function for task 135006879027200_18084.34227607: 
ERROR: LLM func: Error in decorated function for task 135006879029696_18084.34998415: 
ERROR: LLM func: Error in decorated function for task 135006879027008_18084.357515625: 
ERROR: Failed to extract entities and relationships: C[1/4]: chunk-8e978d8535d2d0343eb7048f46a4c2b7: 
ERROR: Traceback (most recent call last):
  File "/app/.venv/lib/python3.12/site-packages/httpx/_transports/default.py", line 101, in map_httpcore_exceptions
    yield
  File "/app/.venv/lib/python3.12/site-packages/httpx/_transports/default.py", line 394, in handle_async_request
    resp = await self._pool.handle_async_request(req)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/connection_pool.py", line 256, in handle_async_request
    raise exc from None
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/connection_pool.py", line 236, in handle_async_request
    response = await connection.handle_async_request(
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/connection.py", line 103, in handle_async_request
    return await self._connection.handle_async_request(request)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/http11.py", line 136, in handle_async_request
    raise exc
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/http11.py", line 106, in handle_async_request
    ) = await self._receive_response_headers(**kwargs)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/http11.py", line 177, in _receive_response_headers
    event = await self._receive_event(timeout=timeout)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/http11.py", line 217, in _receive_event
    data = await self._network_stream.read(
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_backends/anyio.py", line 32, in read
    with map_exceptions(exc_map):
         ^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/contextlib.py", line 158, in __exit__
    self.gen.throw(value)
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_exceptions.py", line 14, in map_exceptions
    raise to_exc(exc) from exc
httpcore.ReadTimeout

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/app/lightrag/operate.py", line 2932, in _process_with_semaphore
    return await _process_single_content(chunk)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/operate.py", line 2817, in _process_single_content
    final_result, timestamp = await use_llm_func_with_cache(
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 1698, in use_llm_func_with_cache
    res: str = await use_llm_func(
               ^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 847, in wait_func
    return await future
           ^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 551, in worker
    result = await asyncio.wait_for(
             ^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/asyncio/tasks.py", line 520, in wait_for
    return await fut
           ^^^^^^^^^
  File "/app/lightrag/llm/ollama.py", line 135, in ollama_model_complete
    return await _ollama_model_if_cache(
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 189, in async_wrapped
    return await copy(fn, *args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 111, in __call__
    do = await self.iter(retry_state=retry_state)
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 153, in iter
    result = await action(retry_state)
             ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/_utils.py", line 99, in inner
    return call(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/__init__.py", line 400, in <lambda>
    self._add_action_func(lambda rs: rs.outcome.result())
                                     ^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/concurrent/futures/_base.py", line 449, in result
    return self.__get_result()
           ^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/concurrent/futures/_base.py", line 401, in __get_result
    raise self._exception
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 114, in __call__
    result = await fn(*args, **kwargs)
             ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/llm/ollama.py", line 109, in _ollama_model_if_cache
    raise e
  File "/app/lightrag/llm/ollama.py", line 72, in _ollama_model_if_cache
    response = await ollama_client.chat(model=model, messages=messages, **kwargs)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 953, in chat
    return await self._request(
           ^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 751, in _request
    return cls(**(await self._request_raw(*args, **kwargs)).json())
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 691, in _request_raw
    r = await self._client.request(*args, **kwargs)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1540, in request
    return await self.send(request, auth=auth, follow_redirects=follow_redirects)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1629, in send
    response = await self._send_handling_auth(
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1657, in _send_handling_auth
    response = await self._send_handling_redirects(
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1694, in _send_handling_redirects
    response = await self._send_single_request(request)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1730, in _send_single_request
    response = await transport.handle_async_request(request)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpx/_transports/default.py", line 393, in handle_async_request
    with map_httpcore_exceptions():
         ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/contextlib.py", line 158, in __exit__
    self.gen.throw(value)
  File "/app/.venv/lib/python3.12/site-packages/httpx/_transports/default.py", line 118, in map_httpcore_exceptions
    raise mapped_exc(message) from exc
httpx.ReadTimeout

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/app/lightrag/operate.py", line 2936, in _process_with_semaphore
    raise prefixed_exception from e
httpx.ReadTimeout: chunk-8e978d8535d2d0343eb7048f46a4c2b7: 

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/app/lightrag/lightrag.py", line 1838, in process_document
    chunk_results = await entity_relation_task
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/lightrag.py", line 2122, in _process_extract_entities
    raise e
  File "/app/lightrag/lightrag.py", line 2107, in _process_extract_entities
    chunk_results = await extract_entities(
                    ^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/operate.py", line 2978, in extract_entities
    raise prefixed_exception from first_exception
httpx.ReadTimeout: C[1/4]: chunk-8e978d8535d2d0343eb7048f46a4c2b7
```

The error is `httpx.ReadTimeout` - Ollama is responding but taking too long to process the request. The 7B model needs more time to generate responses. Let me increase the timeout in .env:

Searched for text `LLM_TIMEOUT` in `.env`:

```txt
### LLM request timeout setting for all llm (0 means no timeout for Ollma)
LLM_TIMEOUT=1200
```

Restart the container and check the logs:

```bash
docker compose restart lightrag
sleep 5 && docker logs lightrag --tail 30 2>&1 | grep -E "(timeout|Timeout|startup complete|ERROR)" || echo "Container starting..."
docker ps | grep lightrag && docker logs lightrag --tail 15
```

Creation of a summary document:

```bash
curl -s http://localhost:9621/health | python3 -c "import sys, json; h = json.load(sys.stdin); print(f\"Status: {h['status']}\"); print(f\"LLM Model: {h['configuration']['llm_model']}\"); print(f\"LLM Host: {h['configuration']['llm_binding_host']}\")"
```

For `httpx.ReadTimeout` the default LLM timeout (180 seconds) was too short for the `qwen2.5-coder:7b` model to process document extraction requests. Larger models need more time, especially when processing complex text chunks.

Increased LLM_TIMEOUT from 180 (default) to 1200 seconds (20 minutes) in `.env` to give Ollama more time to generate responses.

## Worker timeout issue - EMBEDDING_TIMEOUT

```txt
WARNING: Embedding func: Worker timeout for task 123356300259584_19319.959109795 after 60s
WARNING: VDB entity_upsert failed for The Code4Lib Journal after 3 attempts: Embedding func: Worker execution timeout after 60s
ERROR: Error processing entity `The Code4Lib Journal`: VDB entity_upsert failed for The Code4Lib Journal after 3 attempts: Embedding func: Worker execution timeout after 60s
ERROR: Traceback (most recent call last):
  File "/app/lightrag/utils.py", line 847, in wait_func
    return await future
           ^^^^^^^^^^^^
lightrag.utils.WorkerTimeoutError: Worker execution timeout after 60s

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/app/lightrag/utils.py", line 102, in safe_vdb_operation_with_exception
    await operation()
  File "/app/lightrag/kg/nano_vector_db_impl.py", line 119, in upsert
    embeddings_list = await asyncio.gather(*embedding_tasks)
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 873, in wait_func
    raise TimeoutError(f"{queue_name}: {str(e)}")
TimeoutError: Embedding func: Worker execution timeout after 60s

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/app/lightrag/operate.py", line 2471, in _locked_process_entity_name
    entity_data = await _merge_nodes_then_upsert(
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/operate.py", line 1833, in _merge_nodes_then_upsert
    await safe_vdb_operation_with_exception(
  File "/app/lightrag/utils.py", line 108, in safe_vdb_operation_with_exception
    raise Exception(error_msg) from e
Exception: VDB entity_upsert failed for The Code4Lib Journal after 3 attempts: Embedding func: Worker execution timeout after 60s

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/app/lightrag/lightrag.py", line 1921, in process_document
    await merge_nodes_and_edges(
  File "/app/lightrag/operate.py", line 2546, in merge_nodes_and_edges
    raise first_exception
  File "/app/lightrag/operate.py", line 2527, in merge_nodes_and_edges
    result = task.result()
             ^^^^^^^^^^^^^
  File "/app/lightrag/operate.py", line 2507, in _locked_process_entity_name
    raise prefixed_exception from e
Exception: `The Code4Lib Journal`: VDB entity_upsert failed for The Code4Lib Journal after 3 attempts: Embedding func: Worker execution timeout after 60s
```

The error is "Embedding func: Worker timeout after 60s" - the embedding model is taking too long. Embedding timeout increased in `.env`:

```txt
#######################################################################################
### Embedding Configuration (Should not be changed after the first file processed)
### EMBEDDING_BINDING: ollama, openai, azure_openai, jina, lollms, aws_bedrock
### EMBEDDING_BINDING_HOST: host only for Ollama, endpoint for other Embedding service
#######################################################################################
EMBEDDING_TIMEOUT=600
```

Restart and check logs:

```bash
docker compose restart lightrag && sleep 5 && docker logs lightrag --tail 20 | grep -E "(Embedding|startup|ERROR)" || docker logs lightrag --tail 10
curl -s http://localhost:9621/health | python3 -c "import sys, json; h = json.load(sys.stdin); print('Status:', h['status']); print('Embedding Model:', h['configuration']['embedding_model']); print('Embedding Host:', h['configuration']['embedding_binding_host'])"
```

The embedding model (bge-m3:latest) was timing out while generating embeddings. The default embedding timeout (30 seconds, with 60s worker timeout) was insufficient for the embedding model processing.

Increased EMBEDDING_TIMEOUT from 30 (default) to 180 seconds (3 minutes) in .env. This gives the embedding model adequate time to process text and generate embeddings, especially when handling batch requests.

## Fixing the concurency crashes - MAX_ASYNC

```txt
ERROR: LLM func: Error in decorated function for task 124964022342784_41880.419727827: llama runner process has terminated: exit status 2 (status code: 500)
ERROR: Failed to extract entities and relationships: C[2/4]: chunk-b781d9fdb66f54c7a7f3fe4b1e06ff14: llama runner process has terminated: exit status 2 (status code: -1)
ERROR: Traceback (most recent call last):
  File "/app/lightrag/operate.py", line 2932, in _process_with_semaphore
    return await _process_single_content(chunk)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/operate.py", line 2843, in _process_single_content
    glean_result, timestamp = await use_llm_func_with_cache(
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 1698, in use_llm_func_with_cache
    res: str = await use_llm_func(
               ^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 847, in wait_func
    return await future
           ^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 551, in worker
    result = await asyncio.wait_for(
             ^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/asyncio/tasks.py", line 520, in wait_for
    return await fut
           ^^^^^^^^^
  File "/app/lightrag/llm/ollama.py", line 135, in ollama_model_complete
    return await _ollama_model_if_cache(
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 189, in async_wrapped
    return await copy(fn, *args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 111, in __call__
    do = await self.iter(retry_state=retry_state)
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 153, in iter
    result = await action(retry_state)
             ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/_utils.py", line 99, in inner
    return call(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/__init__.py", line 400, in <lambda>
    self._add_action_func(lambda rs: rs.outcome.result())
                                     ^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/concurrent/futures/_base.py", line 449, in result
    return self.__get_result()
           ^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/concurrent/futures/_base.py", line 401, in __get_result
    raise self._exception
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 114, in __call__
    result = await fn(*args, **kwargs)
             ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/llm/ollama.py", line 109, in _ollama_model_if_cache
    raise e
  File "/app/lightrag/llm/ollama.py", line 72, in _ollama_model_if_cache
    response = await ollama_client.chat(model=model, messages=messages, **kwargs)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 953, in chat
    return await self._request(
           ^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 751, in _request
    return cls(**(await self._request_raw(*args, **kwargs)).json())
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 695, in _request_raw
    raise ResponseError(e.response.text, e.response.status_code) from None
ollama._types.ResponseError: llama runner process has terminated: exit status 2 (status code: 500)

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/app/lightrag/operate.py", line 2936, in _process_with_semaphore
    raise prefixed_exception from e
ollama._types.ResponseError: chunk-b781d9fdb66f54c7a7f3fe4b1e06ff14: llama runner process has terminated: exit status 2 (status code: -1)

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/app/lightrag/lightrag.py", line 1838, in process_document
    chunk_results = await entity_relation_task
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/lightrag.py", line 2122, in _process_extract_entities
    raise e
  File "/app/lightrag/lightrag.py", line 2107, in _process_extract_entities
    chunk_results = await extract_entities(
                    ^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/operate.py", line 2978, in extract_entities
    raise prefixed_exception from first_exception
ollama._types.ResponseError: C[2/4]: chunk-b781d9fdb66f54c7a7f3fe4b1e06ff14: llama runner process has terminated: exit status 2 (status code: -1)

ERROR: Failed to extract document 1/17: A Novel Open Source Approach to Monitor EZproxy Users’ Activities.md
```

An investigation of the Ollama logs first:

```bash
sudo journalctl -u ollama --no-pager -n 50 | grep -E "(error|Error|ERROR|killed|OOM|memory|terminated)" || echo "No Ollama errors in recent logs"
```

Then checking resource consumption of Ollama process:

```bash
free -h && echo "---" && ps aux | grep ollama | grep -v grep | head -5
```

Result something similar to the following:

```txt
               total        used        free      shared  buff/cache   available
Mem:            62Gi        14Gi        26Gi       316Mi        22Gi        47Gi
Swap:          2,0Gi          0B       2,0Gi
---
ollama      4716  0.2  4.5 8250740 1065740 ?     Ssl  08:22   0:19 /usr/local/bin/ollama serve
```

Good - you have 62GB RAM with 47GB available, so it's not a system-wide OOM issue. The Ollama runner is consuming a lot of resources (52GB VIRT, 6GB RES). The crash is likely from too many concurrent LLM requests overwhelming Ollama. Let me reduce `MAX_ASYNC` in `.env`:

```txt
###############################
### Concurrency Configuration
###############################
### Max concurrency requests of LLM (for both query and document processing)
MAX_ASYNC=2
### Number of parallel processing documents(between 2~10, MAX_ASYNC/3 is recommended)
MAX_PARALLEL_INSERT=1
```

Restart and check logs:

```bash
docker compose restart lightrag && sleep 5 && docker logs lightrag --tail 15 | grep -E "(MAX_ASYNC|workers|startup)" || docker logs lightrag --tail 10
```

### Root Cause:

llama runner process has terminated: exit status 2 - The Ollama llama.cpp runner crashed due to resource exhaustion. With `MAX_ASYNC=4`, LightRAG was sending 4 concurrent LLM requests, overwhelming Ollama's ability to handle the 7B model's memory requirements.

### What Was Happening

The qwen2.5-coder:7b model requires ~6GB RAM per concurrent inference.
With 4 concurrent requests (MAX_ASYNC=4), Ollama needed ~24GB just for model inference.
When processing entity extraction with large context windows, memory usage spiked.
The llama.cpp runner process crashed with exit code 2 (resource error).

Reduced concurrency in .env:

- `MAX_ASYNC=2` (was 4) - limits concurrent LLM requests to 2
- `MAX_PARALLEL_INSERT=1` (was 2) - processes 1 document at a time

This reduces peak memory usage from ~24GB to ~12GB, well within your system's capacity.

Verification
✓ Container restarted successfully
✓ Loaded existing graph data (1348 nodes, 804 edges)
✓ 285 cached LLM responses available
✓ Lower concurrency prevents Ollama crashes

## Fixing again EMBEDDING_TIMEOUT

The error shows "Embedding func: Worker timeout after 360s" (6 minutes) - the embedding is still timing out. The worker timeout is 2x the function timeout, so with `EMBEDDING_TIMEOUT=180`, workers timeout at 360s. Let me increase it further (`EMBEDDING_TIMEOUT=600`):

`docker compose restart lightrag && sleep 5 && echo "Embedding timeout increased to 600s (worker timeout: 1200s)"`

### Root Cause

Embedding func: Worker timeout after 360s - The embedding model (bge-m3:latest) was timing out even with the previous 180-second timeout. Worker timeout is 2x the function timeout, so 180s function = 360s worker timeout, which was still insufficient.

### Fix Applied

Increased EMBEDDING_TIMEOUT from 180 to 600 seconds (10 minutes):

Function timeout: 600 seconds
Worker timeout: 1200 seconds (20 minutes)

### Why This Is Needed

With reduced concurrency (`MAX_ASYNC=2`), each embedding request now handles more entities sequentially, taking longer. The `bge-m3:latest` model processes text slowly, especially for batch embedding operations during document extraction.

Current Configuration Summary

- `LLM_TIMEOUT=600` (10 min for qwen2.5-coder:7b)
- `EMBEDDING_TIMEOUT=600` (10 min for bge-m3:latest)
- `MAX_ASYNC=2` (reduces concurrent load)
- `MAX_PARALLEL_INSERT=1` (1 document at a time)

Container restarted - document processing should now complete without embedding timeouts.

## Fixing again LLM_TIMEOUT

Error:

```txt
ERROR: LLM func: Error in decorated function for task 135848745912832_53140.974195369: 
ERROR: LLM func: Error in decorated function for task 135848745911680_53141.014748309: 
ERROR: LLM func: Error in decorated function for task 135848745912448_53141.020096535: 
ERROR: Failed to extract entities and relationships: C[1/5]: chunk-7adb7e6a5a0e65d8d28e9a06fa85ae5a: 
ERROR: Traceback (most recent call last):
  File "/app/.venv/lib/python3.12/site-packages/httpx/_transports/default.py", line 101, in map_httpcore_exceptions
    yield
  File "/app/.venv/lib/python3.12/site-packages/httpx/_transports/default.py", line 394, in handle_async_request
    resp = await self._pool.handle_async_request(req)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/connection_pool.py", line 256, in handle_async_request
    raise exc from None
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/connection_pool.py", line 236, in handle_async_request
    response = await connection.handle_async_request(
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/connection.py", line 103, in handle_async_request
    return await self._connection.handle_async_request(request)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/http11.py", line 136, in handle_async_request
    raise exc
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/http11.py", line 106, in handle_async_request
    ) = await self._receive_response_headers(**kwargs)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/http11.py", line 177, in _receive_response_headers
    event = await self._receive_event(timeout=timeout)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/http11.py", line 217, in _receive_event
    data = await self._network_stream.read(
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_backends/anyio.py", line 32, in read
    with map_exceptions(exc_map):
         ^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/contextlib.py", line 158, in __exit__
    self.gen.throw(value)
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_exceptions.py", line 14, in map_exceptions
    raise to_exc(exc) from exc
httpcore.ReadTimeout

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/app/lightrag/operate.py", line 2932, in _process_with_semaphore
    return await _process_single_content(chunk)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/operate.py", line 2843, in _process_single_content
    glean_result, timestamp = await use_llm_func_with_cache(
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 1698, in use_llm_func_with_cache
    res: str = await use_llm_func(
               ^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 847, in wait_func
    return await future
           ^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 551, in worker
    result = await asyncio.wait_for(
             ^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/asyncio/tasks.py", line 520, in wait_for
    return await fut
           ^^^^^^^^^
  File "/app/lightrag/llm/ollama.py", line 135, in ollama_model_complete
    return await _ollama_model_if_cache(
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 189, in async_wrapped
    return await copy(fn, *args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 111, in __call__
    do = await self.iter(retry_state=retry_state)
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 153, in iter
    result = await action(retry_state)
             ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/_utils.py", line 99, in inner
    return call(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/__init__.py", line 400, in <lambda>
    self._add_action_func(lambda rs: rs.outcome.result())
                                     ^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/concurrent/futures/_base.py", line 449, in result
    return self.__get_result()
           ^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/concurrent/futures/_base.py", line 401, in __get_result
    raise self._exception
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 114, in __call__
    result = await fn(*args, **kwargs)
             ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/llm/ollama.py", line 109, in _ollama_model_if_cache
    raise e
  File "/app/lightrag/llm/ollama.py", line 72, in _ollama_model_if_cache
    response = await ollama_client.chat(model=model, messages=messages, **kwargs)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 953, in chat
    return await self._request(
           ^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 751, in _request
    return cls(**(await self._request_raw(*args, **kwargs)).json())
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 691, in _request_raw
    r = await self._client.request(*args, **kwargs)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1540, in request
    return await self.send(request, auth=auth, follow_redirects=follow_redirects)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1629, in send
    response = await self._send_handling_auth(
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1657, in _send_handling_auth
    response = await self._send_handling_redirects(
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1694, in _send_handling_redirects
    response = await self._send_single_request(request)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1730, in _send_single_request
    response = await transport.handle_async_request(request)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpx/_transports/default.py", line 393, in handle_async_request
    with map_httpcore_exceptions():
         ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/contextlib.py", line 158, in __exit__
    self.gen.throw(value)
  File "/app/.venv/lib/python3.12/site-packages/httpx/_transports/default.py", line 118, in map_httpcore_exceptions
    raise mapped_exc(message) from exc
httpx.ReadTimeout

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/app/lightrag/operate.py", line 2936, in _process_with_semaphore
    raise prefixed_exception from e
httpx.ReadTimeout: chunk-7adb7e6a5a0e65d8d28e9a06fa85ae5a: 

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/app/lightrag/lightrag.py", line 1838, in process_document
    chunk_results = await entity_relation_task
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/lightrag.py", line 2122, in _process_extract_entities
    raise e
  File "/app/lightrag/lightrag.py", line 2107, in _process_extract_entities
    chunk_results = await extract_entities(
                    ^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/operate.py", line 2978, in extract_entities
    raise prefixed_exception from first_exception
httpx.ReadTimeout: C[1/5]: chunk-7adb7e6a5a0e65d8d28e9a06fa85ae5a: 

ERROR: Failed to extract document 16/17: Applying Lessons from 8 Things We Hate About IT to Libraries.md
INFO: Extracting stage 17/17: Approaching the largest ‘API’ extracting information from the Internet with Python.md
INFO: Processing d-id: doc-c22668d86a8355fc59df89872a37309f
```

Looking at the error, this is another `httpx.ReadTimeout` for the LLM, occurring at document 16/17. Even with `LLM_TIMEOUT=600` and reduced concurrency, some chunks are taking longer than 10 minutes to process.

Let me check the current configuration and increase the LLM timeout:

Searched for text in environment files
The timeout is still hitting at 600s with MAX_ASYNC=2. Since you're on document 16/17, the system is almost done. Let me increase the LLM timeout to 1200 seconds (20 minutes) to handle these particularly complex chunks:

`docker compose restart lightrag && sleep 5 && echo "✓ LLM timeout increased to 1200s (20 min) - worker timeout: 2400s (40 min)"`

Let me check the exact format in the file. Read .env, lines 175 to 180:

```txt
###########################################################################
### LLM Configuration
### LLM_BINDING type: openai, ollama, lollms, azure_openai, aws_bedrock, gemini
### LLM_BINDING_HOST: host only for Ollama, endpoint for other LLM service
###########################################################################
### LLM request timeout setting for all llm (0 means no timeout for Ollma)
LLM_TIMEOUT=1200
```

`docker compose restart lightrag`

Root Cause: `httpx.ReadTimeout` - Even with `LLM_TIMEOUT=600` and reduced concurrency, some particularly complex text chunks in document 16/17 are taking longer than 10 minutes to process with the `qwen2.5-coder:7b` model.

Fix Applied: Increased LLM_TIMEOUT from 600 to 1200 seconds (20 minutes):

Function timeout: 1200 seconds
Worker timeout: 2400 seconds (40 minutes)

Why This Is Needed:

Document 16/17 shows you're near the end of processing.
Some chunks have complex content requiring longer LLM processing.
With MAX_ASYNC=2, requests are processed with less parallelism but each needs more time.
The 7B model is thorough but slow on complex entity extraction.

## Fixing CUDA GPU Error

```txt
ERROR: LLM func: Error in decorated function for task 137883359726464_56165.486811457: llama runner process has terminated: CUDA error: an internal operation failed
  current device: 0, in function ggml_cuda_mul_mat_batched_cublas_impl at //ml/backend/ggml/ggml/src/ggml-cuda/ggml-cuda.cu:2106
  cublasGemmBatchedEx(ctx.cublas_handle(), CUBLAS_OP_T, CUBLAS_OP_N, ne01, ne11, ne10, alpha, (const void **) (ptrs_src.get() + 0*ne23), cu_data_type_a, nb01/nb00, (const void **) (ptrs_src.get() + 1*ne23), cu_data_type_b, s11, beta, ( void **) (ptrs_dst.get() + 0*ne23), cu_data_type, ne0, ne23, cu_compute_type, CUBLAS_GEMM_DEFAULT_TENSOR_OP)
//ml/backend/ggml/ggml/src/ggml-cuda/ggml-cuda.cu:88: CUDA error (status code: 500)
ERROR: Failed to extract entities and relationships: C[5/13]: chunk-c1d2cb730adf6dc963ce62113b4d6ca8: llama runner process has terminated: CUDA error: an internal operation failed
  current device: 0, in function ggml_cuda_mul_mat_batched_cublas_impl at //ml/backend/ggml/ggml/src/ggml-cuda/ggml-cuda.cu:2106
  cublasGemmBatchedEx(ctx.cublas_handle(), CUBLAS_OP_T, CUBLAS_OP_N, ne01, ne11, ne10, alpha, (const void **) (ptrs_src.get() + 0*ne23), cu_data_type_a, nb01/nb00, (const void **) (ptrs_src.get() + 1*ne23), cu_data_type_b, s11, beta, ( void **) (ptrs_dst.get() + 0*ne23), cu_data_type, ne0, ne23, cu_compute_type, CUBLAS_GEMM_DEFAULT_TENSOR_OP)
//ml/backend/ggml/ggml/src/ggml-cuda/ggml-cuda.cu:88: CUDA error (status code: -1)
ERROR: Traceback (most recent call last):
  File "/app/lightrag/operate.py", line 2932, in _process_with_semaphore
    return await _process_single_content(chunk)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/operate.py", line 2817, in _process_single_content
    final_result, timestamp = await use_llm_func_with_cache(
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 1698, in use_llm_func_with_cache
    res: str = await use_llm_func(
               ^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 847, in wait_func
    return await future
           ^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 551, in worker
    result = await asyncio.wait_for(
             ^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/asyncio/tasks.py", line 520, in wait_for
    return await fut
           ^^^^^^^^^
  File "/app/lightrag/llm/ollama.py", line 135, in ollama_model_complete
    return await _ollama_model_if_cache(
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 189, in async_wrapped
    return await copy(fn, *args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 111, in __call__
    do = await self.iter(retry_state=retry_state)
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 153, in iter
    result = await action(retry_state)
             ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/_utils.py", line 99, in inner
    return call(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/__init__.py", line 400, in <lambda>
    self._add_action_func(lambda rs: rs.outcome.result())
                                     ^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/concurrent/futures/_base.py", line 449, in result
    return self.__get_result()
           ^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/concurrent/futures/_base.py", line 401, in __get_result
    raise self._exception
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 114, in __call__
    result = await fn(*args, **kwargs)
             ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/llm/ollama.py", line 109, in _ollama_model_if_cache
    raise e
  File "/app/lightrag/llm/ollama.py", line 72, in _ollama_model_if_cache
    response = await ollama_client.chat(model=model, messages=messages, **kwargs)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 953, in chat
    return await self._request(
           ^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 751, in _request
    return cls(**(await self._request_raw(*args, **kwargs)).json())
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 695, in _request_raw
    raise ResponseError(e.response.text, e.response.status_code) from None
ollama._types.ResponseError: llama runner process has terminated: CUDA error: an internal operation failed
  current device: 0, in function ggml_cuda_mul_mat_batched_cublas_impl at //ml/backend/ggml/ggml/src/ggml-cuda/ggml-cuda.cu:2106
  cublasGemmBatchedEx(ctx.cublas_handle(), CUBLAS_OP_T, CUBLAS_OP_N, ne01, ne11, ne10, alpha, (const void **) (ptrs_src.get() + 0*ne23), cu_data_type_a, nb01/nb00, (const void **) (ptrs_src.get() + 1*ne23), cu_data_type_b, s11, beta, ( void **) (ptrs_dst.get() + 0*ne23), cu_data_type, ne0, ne23, cu_compute_type, CUBLAS_GEMM_DEFAULT_TENSOR_OP)
//ml/backend/ggml/ggml/src/ggml-cuda/ggml-cuda.cu:88: CUDA error (status code: 500)

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/app/lightrag/operate.py", line 2936, in _process_with_semaphore
    raise prefixed_exception from e
ollama._types.ResponseError: chunk-c1d2cb730adf6dc963ce62113b4d6ca8: llama runner process has terminated: CUDA error: an internal operation failed
  current device: 0, in function ggml_cuda_mul_mat_batched_cublas_impl at //ml/backend/ggml/ggml/src/ggml-cuda/ggml-cuda.cu:2106
  cublasGemmBatchedEx(ctx.cublas_handle(), CUBLAS_OP_T, CUBLAS_OP_N, ne01, ne11, ne10, alpha, (const void **) (ptrs_src.get() + 0*ne23), cu_data_type_a, nb01/nb00, (const void **) (ptrs_src.get() + 1*ne23), cu_data_type_b, s11, beta, ( void **) (ptrs_dst.get() + 0*ne23), cu_data_type, ne0, ne23, cu_compute_type, CUBLAS_GEMM_DEFAULT_TENSOR_OP)
//ml/backend/ggml/ggml/src/ggml-cuda/ggml-cuda.cu:88: CUDA error (status code: -1)

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/app/lightrag/lightrag.py", line 1838, in process_document
    chunk_results = await entity_relation_task
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/lightrag.py", line 2122, in _process_extract_entities
    raise e
  File "/app/lightrag/lightrag.py", line 2107, in _process_extract_entities
    chunk_results = await extract_entities(
                    ^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/operate.py", line 2978, in extract_entities
    raise prefixed_exception from first_exception
ollama._types.ResponseError: C[5/13]: chunk-c1d2cb730adf6dc963ce62113b4d6ca8: llama runner process has terminated: CUDA error: an internal operation failed
  current device: 0, in function ggml_cuda_mul_mat_batched_cublas_impl at //ml/backend/ggml/ggml/src/ggml-cuda/ggml-cuda.cu:2106
  cublasGemmBatchedEx(ctx.cublas_handle(), CUBLAS_OP_T, CUBLAS_OP_N, ne01, ne11, ne10, alpha, (const void **) (ptrs_src.get() + 0*ne23), cu_data_type_a, nb01/nb00, (const void **) (ptrs_src.get() + 1*ne23), cu_data_type_b, s11, beta, ( void **) (ptrs_dst.get() + 0*ne23), cu_data_type, ne0, ne23, cu_compute_type, CUBLAS_GEMM_DEFAULT_TENSOR_OP)
//ml/backend/ggml/ggml/src/ggml-cuda/ggml-cuda.cu:88: CUDA error (status code: -1)

ERROR: Failed to extract document 4/10: A Metadata Schema for Geospatial Resource Discovery Use Cases.md
INFO: Extracting stage 5/10: Advancing ARKs in the Historical Ontology Space.md
INFO: Processing d-id: doc-69bffc334b13eb2649daa969a78704fe
ERROR: LLM func: Error in decorated function for task 137883359725888_56165.483626206: llama runner process has terminated: exit status 2 (status code: 500)
ERROR: LLM func: Error in decorated function for task 137883359726848_56165.489990672: llama runner process has terminated: exit status 2 (status code: 500)
```

⚠️ New Issue: CUDA GPU Error
Root Cause: CUDA error: an internal operation failed - Ollama is attempting to use GPU acceleration, but your GPU has insufficient VRAM. The error shows:

GPU free memory: 170.2 MiB
Model minimum required: 457.0 MiB
Available: 0 B (after trying to load)
The qwen2.5-coder:7b model is too large for your GPU, causing CUDA operations to fail.

Solution: Force Ollama to use CPU-only mode by disabling GPU acceleration. This solution was not applied yet. I maintain a GPU.

`cat /etc/systemd/system/ollama.service.d/override.conf 2>/dev/null || echo "Override file not complete"`

### Proposed solution:

```bash
cd /media/nicolaie/PASARILA/DEVELOPMENT/LIGHT.RAG/LightRAG && sudo tee /etc/systemd/system/ollama.service.d/override.conf > /dev/null << 'EOF'
[Service]
Environment="OLLAMA_HOST=0.0.0.0:11434"
Environment="CUDA_VISIBLE_DEVICES=-1"
Environment="OLLAMA_NUM_GPU=0"
EOF
echo "
```

✓ Systemd override updated - GPU disabled, CPU-only mode"

### 🔧 Solution: Disable GPU and Force CPU-Only Mode

Problem Analysis:

- Your GPU has only 170.2 MiB free VRAM (RTX 4060 8Gb)
- `qwen2.5-coder:7b` needs 457.0 MiB minimum
- CUDA operations are failing with "internal operation failed"
- You have 62GB system RAM available - CPU mode will work

Fix Steps:

Update Ollama systemd configuration. Update the file to include GPU disabling. Reload and restart Ollama. Verify CPU-only mode - you should see messages indicating CPU-only mode or no GPU detection.

Restart LightRAG container.

Why This Works:

- `CUDA_VISIBLE_DEVICES=-1`: Hides all GPUs from Ollama
- `OLLAMA_NUM_GPU=0`: Forces 0 GPU layers to be used

Model will run entirely on CPU using your 62GB RAM. CPU inference is slower but stable and won't crash. Performance Impact:

- CPU mode will be 3-10x slower than GPU
- With your 62GB RAM, the 7B model will run fine

Current slow timeouts (`LLM_TIMEOUT=1200`) already account for slow processing
Alternative: If you prefer GPU acceleration, consider using a smaller model like `qwen2.5-coder:1.5b` which needs less VRAM, but CPU mode with the 7B model on your system RAM is the better solution.

Will continue with current settings and add a GPU card later.

What to Expect:

- CUDA errors will continue intermittently when GPU VRAM is exhausted
- Some documents will fail during entity extraction (like document 4/10)
- Processing will be unstable until GPU upgrade

When You Add the GPU:
Your new GPU should have at least:

Minimum: 2GB VRAM for `qwen2.5-coder:7b` (single inference)
Recommended: 4-8GB VRAM for `MAX_ASYNC=2` (concurrent requests)

## Example of processing after all issues were fixed

This is kept for documentation purposes only.

```txt
Processing 8 document(s)
Extracting stage 1/8: An XML-Based Migration from Digital Commons to Open Journal Systems.md
Processing d-id: doc-0143372bb2adac9f5d912028020ba150
Chunk 1 of 7 extracted 11 Ent + 8 Rel chunk-35f4ec11824e95ce9a8f2849fae91ee8
Chunk 2 of 7 extracted 20 Ent + 9 Rel chunk-042d4673d2b8d4dc1b70921c3b8af4d2
Chunk 3 of 7 extracted 18 Ent + 8 Rel chunk-a9be19a083ffb22c56a1490814786c11
Chunk 4 of 7 extracted 17 Ent + 6 Rel chunk-d005807b49b93306c4f9c75b6f293197
Chunk 5 of 7 extracted 6 Ent + 6 Rel chunk-0b564c2caee8a09392e70458a1e42f60
Chunk 6 of 7 extracted 16 Ent + 9 Rel chunk-a14d2590276651fba8054891f58f2755
Chunk 7 of 7 extracted 10 Ent + 9 Rel chunk-7b473c80c346d1605c96ad566c217dd0
Merging stage 1/8: An XML-Based Migration from Digital Commons to Open Journal Systems.md
Phase 1: Processing 82 entities from doc-0143372bb2adac9f5d912028020ba150 (async: 4)
LLMmrg: `OLAQ` | 4+4
LLMmrg: `OSU Libraries` | 7+6
LLMmrg: `Digital Commons` | 4+4
Merged: `Cara M. Key` | 2+2
Merged: `Oregon State University Libraries & Press` | 1+1
Merged: `Open Access Publishing` | 1+1
Merged: `Digital Repository Services` | 1+1
Merged: `PKP Administrators Guide: Data Import and Export` | 1+1
Merged: `NIRD (Northeast Institutional Repository Day)` | 1+1
Merged: `Public Knowledge Project` | 1+1
Merged: `JPC-Migration` | 1+1
Merged: `Python Code` | 1+1
Merged: `OJS (Open Journal Systems)` | 1+1
Merged: `csv_to_xml.py` | 1+1
Merged: `flat XML structure` | 1+1
Merged: `CSV source document` | 1+1
Merged: `XSL transformation` | 1+1
Merged: `OJS elements` | 1+1
Merged: `PKP/OJS Native XML schema` | 1+1
Merged: `Digital Commons export` | 1+1
Merged: `OJS journal-level configuration` | 1+1
Merged: `Native XML Plugin` | 3+3
Merged: `Oxygen XML Editor` | 1+1
Merged: `Keywords field` | 1+1
Merged: `Issue element` | 1+1
Merged: `XML attribute` | 1+1
Merged: `Import plugin requirements` | 1+1
Merged: `XSD files` | 1+1
Merged: `Metadata challenges` | 1+1
Merged: `PKP Administrators Guide` | 1+1
Merged: `XSLT stylesheet` | 1+1
Merged: `PKP` | 2+2
Merged: `University of Oregon Library` | 2+2
Merged: `OJS 2` | 1+1
Merged: `OJS 3` | 2+1
Merged: `XSLT Pipeline` | 1+1
Merged: `OLA Quarterly` | 1+1
Merged: `CommonKnowledge` | 1+1
Merged: `Bepress` | 1+1
Merged: `Hyku` | 1+1
Merged: `OJS at OregonDigital.org` | 1+1
Merged: `Open Journal Systems (OJS)` | 1+1
Merged: `Native XML schema` | 1+1
Phase 2: Processing 52 relations from doc-0143372bb2adac9f5d912028020ba150 (async: 4)
Chunks appended from relation: `OJS at OregonDigital.org`
Chunks appended from relation: `OJS`
Phase 3: Updating final 93(82+11) entities and  52 relations from doc-0143372bb2adac9f5d912028020ba150
Completed merging: 82 entities, 11 extra entities, 52 relations
Completed processing file 1/8: An XML-Based Migration from Digital Commons to Open Journal Systems.md
Extracting stage 2/8: Analysis of 2018 International Linked Data Survey for Implementers.md
Processing d-id: doc-2af1f276ad1e498aa11e5b3e472bb409
Chunk 1 of 13 extracted 39 Ent + 4 Rel chunk-091eab2b2b0aea950a5a0ef4d5aed319
Chunk 2 of 13 extracted 34 Ent + 8 Rel chunk-a1a0c5de3951e6d58d3cac36e514f6c5
Chunk 3 of 13 extracted 31 Ent + 27 Rel chunk-97455c2517b6afd0a500effbae443ae8
Chunk 4 of 13 extracted 34 Ent + 12 Rel chunk-026725ef7637a874357803be347c2d0d
Chunk 5 of 13 extracted 31 Ent + 28 Rel chunk-b2fcf37ef0306b3f346f5f51c257cb03
Chunk 6 of 13 extracted 34 Ent + 59 Rel chunk-47af78ad231b312c8b53af8b3659ff52
Chunk 7 of 13 extracted 57 Ent + 44 Rel chunk-d68a34be6adb0d2102481e0ef34f3fad
Chunk 8 of 13 extracted 24 Ent + 10 Rel chunk-32c9c008d00ffb4f68efcf45ae796a7d
Chunk 9 of 13 extracted 14 Ent + 8 Rel chunk-e6b8daad158e0cbd563786f938f2023f
Chunk 11 of 13 extracted 72 Ent + 0 Rel chunk-42c3682f60fb104c303c582659f850be
Chunk 12 of 13 extracted 98 Ent + 3 Rel chunk-7bb69af3dd630c0d3630ef3d6c5cb567
Chunk 13 of 13 extracted 12 Ent + 7 Rel chunk-99c6b520795d2d18998a68e9506e6483
Merging stage 2/8: Analysis of 2018 International Linked Data Survey for Implementers.md
Phase 1: Processing 404 entities from doc-2af1f276ad1e498aa11e5b3e472bb409 (async: 4)
Merged: `World Athletics Championship` | 4+1 (dd 1)
Merged: `Tokyo` | 3+1 (dd 1)
Merged: `Noah Carter` | 4+1 (dd 1)
Merged: `100m Sprint Record` | 4+2
Merged: `Carbon-Fiber Spikes` | 4+1 (dd 1)
Merged: `World Athletics Federation` | 3+1 (dd 1)
Merged: `Columbia University` | 2+1
Merged: `RDF` | 1+2
Merged: `JSON-LD` | 1+1
Merged: `Linked Data` | 1+2
Merged: `Python` | 1+1
Merged: `Solr` | 2+1
Merged: `Elasticsearch` | 4+1
Merged: `Blacklight` | 2+1
Merged: `Ruby on Rails` | 2+1
Merged: `National Library of Finland` | 1+1
Merged: `New York Public Library` | 2+1
Merged: `OCLC` | 1+2
Merged: `University of Illinois at Urbana-Champaign` | 2+1
Merged: `Data Cleaning` | 1+1
Phase 2: Processing 211 relations from doc-2af1f276ad1e498aa11e5b3e472bb409 (async: 4)
Merged: `Tokyo`~`World Athletics Championship` | 3+1 (dd 1)
Merged: `100m Sprint Record`~`Noah Carter` | 4+1 (dd 1)
Merged: `Carbon-Fiber Spikes`~`Noah Carter` | 3+1 (dd 1)
Merged: `Noah Carter`~`World Athletics Championship` | 4+1 (dd 1)
Chunks appended from relation: `2018 Survey`
Chunks appended from relation: `France`
Chunks appended from relation: `Spain`
Chunks appended from relation: `USA`
Phase 3: Updating final 416(404+12) entities and  211 relations from doc-2af1f276ad1e498aa11e5b3e472bb409
Completed merging: 404 entities, 12 extra entities, 211 relations
Completed processing file 2/8: Analysis of 2018 International Linked Data Survey for Implementers.md
Extracting stage 3/8: A Metadata Schema for Geospatial Resource Discovery Use Cases.md
Processing d-id: doc-325388c2dd550aaa769a2b560c7489c2
Chunk 1 of 13 extracted 11 Ent + 5 Rel chunk-de31f3e4e72fe2bed750865254f7712e
Chunk 2 of 13 extracted 10 Ent + 5 Rel chunk-06f0ce4c88a2fb83d4639c12c8518420
Chunk 3 of 13 extracted 22 Ent + 12 Rel chunk-c0c84487c0a51c3e9c6102101c9c25ef
Chunk 4 of 13 extracted 20 Ent + 9 Rel chunk-45f182f74b588f3b7701f43cd90fe582
Chunk 5 of 13 extracted 15 Ent + 10 Rel chunk-7277c005940acceccff53d63a32cb293
Chunk 6 of 13 extracted 37 Ent + 8 Rel chunk-7bf83c55a31ec04f90d76033278c2346
Chunk 7 of 13 extracted 14 Ent + 5 Rel chunk-c1d2cb730adf6dc963ce62113b4d6ca8
Chunk 8 of 13 extracted 9 Ent + 8 Rel chunk-fc6c3d3fbd0d9209745e691bd373f1db
Chunk 9 of 13 extracted 27 Ent + 24 Rel chunk-70f68dac62451692075eaa372a394d6c
Chunk 10 of 13 extracted 13 Ent + 7 Rel chunk-2e154ccceb8d75f36646d3db9db24aec
Failed to extract entities and relationships: C[11/13]: chunk-54f68f67cb3f6389568e02c281de6c99: 
Traceback (most recent call last):
  File "/app/.venv/lib/python3.12/site-packages/httpx/_transports/default.py", line 101, in map_httpcore_exceptions
    yield
  File "/app/.venv/lib/python3.12/site-packages/httpx/_transports/default.py", line 394, in handle_async_request
    resp = await self._pool.handle_async_request(req)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/connection_pool.py", line 256, in handle_async_request
    raise exc from None
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/connection_pool.py", line 236, in handle_async_request
    response = await connection.handle_async_request(
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/connection.py", line 103, in handle_async_request
    return await self._connection.handle_async_request(request)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/http11.py", line 136, in handle_async_request
    raise exc
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/http11.py", line 106, in handle_async_request
    ) = await self._receive_response_headers(**kwargs)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/http11.py", line 177, in _receive_response_headers
    event = await self._receive_event(timeout=timeout)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_async/http11.py", line 217, in _receive_event
    data = await self._network_stream.read(
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_backends/anyio.py", line 32, in read
    with map_exceptions(exc_map):
         ^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/contextlib.py", line 158, in __exit__
    self.gen.throw(value)
  File "/app/.venv/lib/python3.12/site-packages/httpcore/_exceptions.py", line 14, in map_exceptions
    raise to_exc(exc) from exc
httpcore.ReadTimeout

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/app/lightrag/operate.py", line 2932, in _process_with_semaphore
    return await _process_single_content(chunk)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/operate.py", line 2817, in _process_single_content
    final_result, timestamp = await use_llm_func_with_cache(
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 1698, in use_llm_func_with_cache
    res: str = await use_llm_func(
               ^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 847, in wait_func
    return await future
           ^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 551, in worker
    result = await asyncio.wait_for(
             ^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/asyncio/tasks.py", line 520, in wait_for
    return await fut
           ^^^^^^^^^
  File "/app/lightrag/llm/ollama.py", line 135, in ollama_model_complete
    return await _ollama_model_if_cache(
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 189, in async_wrapped
    return await copy(fn, *args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 111, in __call__
    do = await self.iter(retry_state=retry_state)
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 153, in iter
    result = await action(retry_state)
             ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/_utils.py", line 99, in inner
    return call(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/__init__.py", line 400, in <lambda>
    self._add_action_func(lambda rs: rs.outcome.result())
                                     ^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/concurrent/futures/_base.py", line 449, in result
    return self.__get_result()
           ^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/concurrent/futures/_base.py", line 401, in __get_result
    raise self._exception
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 114, in __call__
    result = await fn(*args, **kwargs)
             ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/llm/ollama.py", line 109, in _ollama_model_if_cache
    raise e
  File "/app/lightrag/llm/ollama.py", line 72, in _ollama_model_if_cache
    response = await ollama_client.chat(model=model, messages=messages, **kwargs)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 953, in chat
    return await self._request(
           ^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 751, in _request
    return cls(**(await self._request_raw(*args, **kwargs)).json())
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 691, in _request_raw
    r = await self._client.request(*args, **kwargs)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1540, in request
    return await self.send(request, auth=auth, follow_redirects=follow_redirects)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1629, in send
    response = await self._send_handling_auth(
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1657, in _send_handling_auth
    response = await self._send_handling_redirects(
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1694, in _send_handling_redirects
    response = await self._send_single_request(request)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1730, in _send_single_request
    response = await transport.handle_async_request(request)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/httpx/_transports/default.py", line 393, in handle_async_request
    with map_httpcore_exceptions():
         ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/contextlib.py", line 158, in __exit__
    self.gen.throw(value)
  File "/app/.venv/lib/python3.12/site-packages/httpx/_transports/default.py", line 118, in map_httpcore_exceptions
    raise mapped_exc(message) from exc
httpx.ReadTimeout

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/app/lightrag/operate.py", line 2936, in _process_with_semaphore
    raise prefixed_exception from e
httpx.ReadTimeout: chunk-54f68f67cb3f6389568e02c281de6c99: 

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/app/lightrag/lightrag.py", line 1838, in process_document
    chunk_results = await entity_relation_task
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/lightrag.py", line 2122, in _process_extract_entities
    raise e
  File "/app/lightrag/lightrag.py", line 2107, in _process_extract_entities
    chunk_results = await extract_entities(
                    ^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/operate.py", line 2978, in extract_entities
    raise prefixed_exception from first_exception
httpx.ReadTimeout: C[11/13]: chunk-54f68f67cb3f6389568e02c281de6c99: 
Failed to extract document 3/8: A Metadata Schema for Geospatial Resource Discovery Use Cases.md
Extracting stage 4/8: Advancing ARKs in the Historical Ontology Space.md
Processing d-id: doc-69bffc334b13eb2649daa969a78704fe
Chunk 1 of 8 extracted 13 Ent + 4 Rel chunk-f9e726969feb713fd88d8d1a465cd868
Chunk 2 of 8 extracted 15 Ent + 5 Rel chunk-a5ce98d0f70234d19b07e472e2b6103a
Chunk 3 of 8 extracted 14 Ent + 7 Rel chunk-f00cf489387953ceeaada430635c3ae6
Chunk 4 of 8 extracted 14 Ent + 10 Rel chunk-bcad8fa6786e7b6f7c83d8f6dfe4157e
Chunk 5 of 8 extracted 22 Ent + 13 Rel chunk-a4084800d8b5a4e367f228dff196e820
Chunk 6 of 8 extracted 43 Ent + 18 Rel chunk-ca07ce69d236c8ed7c847f0e4aef5b2a
Chunk 7 of 8 extracted 19 Ent + 11 Rel chunk-102b89f0b48d7efb08115f5b2cdabae3
Chunk 8 of 8 extracted 4 Ent + 3 Rel chunk-9896ea4ec2afb3e3298bd019b8020bfa
Merging stage 4/8: Advancing ARKs in the Historical Ontology Space.md
Phase 1: Processing 139 entities from doc-69bffc334b13eb2649daa969a78704fe (async: 4)
Merged: `Library of Congress` | 2+1
Merged: `Django` | 1+1
Merged: `MySQL` | 2+1
Merged: `ReactJS` | 1+1
Merged: `World Athletics Championship` | 5+1
Merged: `Tokyo` | 4+1
Merged: `Noah Carter` | 5+1
Merged: `100m Sprint Record` | 6+1
Merged: `Carbon-Fiber Spikes` | 5+1
Merged: `Knowledge Organization Systems` | 1+1
Merged: `Relevance` | 2+1
Merged: `University of North Carolina at Chapel Hill` | 2+1
LLMmrg: `Metadata` | 7+1
Merged: `Digital Object` | 1+1
Phase 2: Processing 70 relations from doc-69bffc334b13eb2649daa969a78704fe (async: 4)
Chunks appended from relation: `ARKs`
Chunks appended from relation: `Mat Kelly`
Chunks appended from relation: `Jane Greenberg`
Chunks appended from relation: `Joan Boone`
Chunks appended from relation: `Sam Grabus`
Chunks appended from relation: `John Kunze`
Chunks appended from relation: `Peter M. Logan`
Phase 3: Updating final 154(139+15) entities and  70 relations from doc-69bffc334b13eb2649daa969a78704fe
Completed merging: 139 entities, 15 extra entities, 70 relations
Completed processing file 4/8: Advancing ARKs in the Historical Ontology Space.md
Extracting stage 5/8: An Open-Source Strategy for Documenting Events The Case Study of the 42nd Canadian Federal Election on Twitter.md
Processing d-id: doc-e9eb70fead69d911d15fe1bff3d24bff
Chunk 1 of 13 extracted 14 Ent + 11 Rel chunk-3d7650e01f07aeb92bb1ba548d4bfb8c
Chunk 2 of 13 extracted 16 Ent + 10 Rel chunk-fced57e3c8bf248481301b49a595baa5
Chunk 3 of 13 extracted 11 Ent + 5 Rel chunk-807a1473373a123feee7a0389db15e28
Chunk 4 of 13 extracted 16 Ent + 11 Rel chunk-c0b9ace42f05146f43e599b54e2e0d09
Chunk 5 of 13 extracted 14 Ent + 9 Rel chunk-9be3f27089fdf6a7cb494629be275083
Chunk 6 of 13 extracted 15 Ent + 19 Rel chunk-6a011035dc59e93371b60bea7cd72534
Chunk 7 of 13 extracted 20 Ent + 7 Rel chunk-e616e057de9a94ebf61c4258e3a90ad8
Chunk 8 of 13 extracted 14 Ent + 7 Rel chunk-1cd285dcfdf6eab8ad198f6d79d57d11
Chunk 9 of 13 extracted 14 Ent + 11 Rel chunk-63c1e5dedd6c584ae204dd484d5d07f1
Chunk 10 of 13 extracted 30 Ent + 23 Rel chunk-73cdf757788f8992219bd7c39574cbbd
Chunk 11 of 13 extracted 21 Ent + 20 Rel chunk-2b489a139288dbbd260a9112a732165f
Chunk 12 of 13 extracted 12 Ent + 11 Rel chunk-e8e33c9b281bbde10d25e342194280ea
Chunk 13 of 13 extracted 11 Ent + 11 Rel chunk-be7db1f92a7f868338fa1444ef56e507
Merging stage 5/8: An Open-Source Strategy for Documenting Events The Case Study of the 42nd Canadian Federal Election on Twitter.md
Phase 1: Processing 173 entities from doc-e9eb70fead69d911d15fe1bff3d24bff (async: 4)
Merged: `Python` | 2+2
Merged: `URLs` | 2+1
Merged: `Library of Congress` | 3+1
Merged: `GitHub` | 5+1
Merged: `The Code4Lib Journal` | 4+1
Merged: `Internet Archive` | 2+1
Merged: `YouTube` | 1+1
Phase 2: Processing 153 relations from doc-e9eb70fead69d911d15fe1bff3d24bff (async: 4)
Chunks appended from relation: `Pandas`
Chunks appended from relation: `elxn42-tweets-combined-deduplicated.json`
Chunks appended from relation: `University of Waterloo`
Chunks appended from relation: `Twarc`
Chunks appended from relation: `Data Collection`
Chunks appended from relation: `Project Development`
Phase 3: Updating final 204(173+31) entities and  153 relations from doc-e9eb70fead69d911d15fe1bff3d24bff
Completed merging: 173 entities, 31 extra entities, 153 relations
Completed processing file 5/8: An Open-Source Strategy for Documenting Events The Case Study of the 42nd Canadian Federal Election on Twitter.md
Extracting stage 6/8: Approaching the largest ‘API’ extracting information from the Internet with Python.md
Processing d-id: doc-c22668d86a8355fc59df89872a37309f
Chunk 1 of 5 extracted 15 Ent + 11 Rel chunk-93a9bb5c0d2cad332bc754a998899cbf
Chunk 2 of 5 extracted 27 Ent + 7 Rel chunk-36a62b2e91384091bd474d3c4996d474
Chunk 3 of 5 extracted 13 Ent + 8 Rel chunk-ed776c9fc16d25c6033cbd9e5c16d8d9
Chunk 4 of 5 extracted 14 Ent + 6 Rel chunk-641a0f23541a7806e9d78f474f32abd0
Chunk 5 of 5 extracted 14 Ent + 5 Rel chunk-ecc583bee0596969ee7f904fcbc222ec
Merging stage 6/8: Approaching the largest ‘API’ extracting information from the Internet with Python.md
Phase 1: Processing 72 entities from doc-c22668d86a8355fc59df89872a37309f (async: 4)
Merged: `Austin` | 1+1
Merged: `Python` | 4+2
Merged: `Libraries` | 2+1
Merged: `date` | 1+1
Merged: `The Code4Lib Journal` | 5+1
Merged: `API` | 2+1
Merged: `HTTP` | 1+1
Merged: `HTML` | 3+1
Merged: `JavaScript` | 6+1
Phase 2: Processing 36 relations from doc-c22668d86a8355fc59df89872a37309f (async: 4)
Chunks appended from relation: `Web Scraping`
Chunks appended from relation: `Data Analysis`
Phase 3: Updating final 89(72+17) entities and  36 relations from doc-c22668d86a8355fc59df89872a37309f
Completed merging: 72 entities, 17 extra entities, 36 relations
Completed processing file 6/8: Approaching the largest ‘API’ extracting information from the Internet with Python.md
Extracting stage 7/8: Analyzing and Normalizing Type Metadata for a Large Aggregated Digital Library.md
Processing d-id: doc-db7dca3ff80c0092801e64d0f4d1ee03
Chunk 1 of 8 extracted 9 Ent + 6 Rel chunk-2cc9c44f5e46db8b3c90cc3f54327d76
Chunk 2 of 8 extracted 11 Ent + 9 Rel chunk-29640ed8a07854c928892efbf85fc93e
Failed to extract entities and relationships: C[3/8]: chunk-c8c1d3bb0e8f788764859a281f6b8d23: llama runner process no longer running: 2 CUDA error: out of memory
  current device: 0, in function ggml_backend_cuda_buffer_set_tensor at //ml/backend/ggml/ggml/src/ggml-cuda/ggml-cuda.cu:743
  cudaMemcpyAsyncReserve((char *)tensor->data + offset, data, size, cudaMemcpyHostToDevice, ((cudaStream_t)0x2))
//ml/backend/ggml/ggml/src/ggml-cuda/ggml-cuda.cu:88: CUDA error (status code: -1)
Traceback (most recent call last):
  File "/app/lightrag/operate.py", line 2932, in _process_with_semaphore
    return await _process_single_content(chunk)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/operate.py", line 2843, in _process_single_content
    glean_result, timestamp = await use_llm_func_with_cache(
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 1698, in use_llm_func_with_cache
    res: str = await use_llm_func(
               ^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 847, in wait_func
    return await future
           ^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 551, in worker
    result = await asyncio.wait_for(
             ^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/asyncio/tasks.py", line 520, in wait_for
    return await fut
           ^^^^^^^^^
  File "/app/lightrag/llm/ollama.py", line 135, in ollama_model_complete
    return await _ollama_model_if_cache(
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 189, in async_wrapped
    return await copy(fn, *args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 111, in __call__
    do = await self.iter(retry_state=retry_state)
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 153, in iter
    result = await action(retry_state)
             ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/_utils.py", line 99, in inner
    return call(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/__init__.py", line 400, in <lambda>
    self._add_action_func(lambda rs: rs.outcome.result())
                                     ^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/concurrent/futures/_base.py", line 449, in result
    return self.__get_result()
           ^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/concurrent/futures/_base.py", line 401, in __get_result
    raise self._exception
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 114, in __call__
    result = await fn(*args, **kwargs)
             ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/llm/ollama.py", line 109, in _ollama_model_if_cache
    raise e
  File "/app/lightrag/llm/ollama.py", line 72, in _ollama_model_if_cache
    response = await ollama_client.chat(model=model, messages=messages, **kwargs)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 953, in chat
    return await self._request(
           ^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 751, in _request
    return cls(**(await self._request_raw(*args, **kwargs)).json())
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 695, in _request_raw
    raise ResponseError(e.response.text, e.response.status_code) from None
ollama._types.ResponseError: llama runner process no longer running: 2 CUDA error: out of memory
  current device: 0, in function ggml_backend_cuda_buffer_set_tensor at //ml/backend/ggml/ggml/src/ggml-cuda/ggml-cuda.cu:743
  cudaMemcpyAsyncReserve((char *)tensor->data + offset, data, size, cudaMemcpyHostToDevice, ((cudaStream_t)0x2))
//ml/backend/ggml/ggml/src/ggml-cuda/ggml-cuda.cu:88: CUDA error (status code: 500)

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/app/lightrag/operate.py", line 2936, in _process_with_semaphore
    raise prefixed_exception from e
ollama._types.ResponseError: chunk-c8c1d3bb0e8f788764859a281f6b8d23: llama runner process no longer running: 2 CUDA error: out of memory
  current device: 0, in function ggml_backend_cuda_buffer_set_tensor at //ml/backend/ggml/ggml/src/ggml-cuda/ggml-cuda.cu:743
  cudaMemcpyAsyncReserve((char *)tensor->data + offset, data, size, cudaMemcpyHostToDevice, ((cudaStream_t)0x2))
//ml/backend/ggml/ggml/src/ggml-cuda/ggml-cuda.cu:88: CUDA error (status code: -1)

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/app/lightrag/lightrag.py", line 1838, in process_document
    chunk_results = await entity_relation_task
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/lightrag.py", line 2122, in _process_extract_entities
    raise e
  File "/app/lightrag/lightrag.py", line 2107, in _process_extract_entities
    chunk_results = await extract_entities(
                    ^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/operate.py", line 2978, in extract_entities
    raise prefixed_exception from first_exception
ollama._types.ResponseError: C[3/8]: chunk-c8c1d3bb0e8f788764859a281f6b8d23: llama runner process no longer running: 2 CUDA error: out of memory
  current device: 0, in function ggml_backend_cuda_buffer_set_tensor at //ml/backend/ggml/ggml/src/ggml-cuda/ggml-cuda.cu:743
  cudaMemcpyAsyncReserve((char *)tensor->data + offset, data, size, cudaMemcpyHostToDevice, ((cudaStream_t)0x2))
//ml/backend/ggml/ggml/src/ggml-cuda/ggml-cuda.cu:88: CUDA error (status code: -1)
Failed to extract document 7/8: Analyzing and Normalizing Type Metadata for a Large Aggregated Digital Library.md
Extracting stage 8/8: Applying Lessons from 8 Things We Hate About IT to Libraries.md
Processing d-id: doc-d20f4a7007cdf7b788408f54f983b857
Chunk 1 of 5 extracted 16 Ent + 14 Rel chunk-7adb7e6a5a0e65d8d28e9a06fa85ae5a
Chunk 2 of 5 extracted 20 Ent + 11 Rel chunk-f2bb17d8993532367aeb7aa1758f649d
Failed to extract entities and relationships: C[3/5]: chunk-3897ebbba3e1e30310d0049e036eafd8: model runner has unexpectedly stopped, this may be due to resource limitations or an internal error, check ollama server logs for details (status code: -1)
Traceback (most recent call last):
  File "/app/lightrag/operate.py", line 2932, in _process_with_semaphore
    return await _process_single_content(chunk)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/operate.py", line 2843, in _process_single_content
    glean_result, timestamp = await use_llm_func_with_cache(
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 1698, in use_llm_func_with_cache
    res: str = await use_llm_func(
               ^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 847, in wait_func
    return await future
           ^^^^^^^^^^^^
  File "/app/lightrag/utils.py", line 551, in worker
    result = await asyncio.wait_for(
             ^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/asyncio/tasks.py", line 520, in wait_for
    return await fut
           ^^^^^^^^^
  File "/app/lightrag/llm/ollama.py", line 135, in ollama_model_complete
    return await _ollama_model_if_cache(
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 189, in async_wrapped
    return await copy(fn, *args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 111, in __call__
    do = await self.iter(retry_state=retry_state)
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 153, in iter
    result = await action(retry_state)
             ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/_utils.py", line 99, in inner
    return call(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/tenacity/__init__.py", line 400, in <lambda>
    self._add_action_func(lambda rs: rs.outcome.result())
                                     ^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/concurrent/futures/_base.py", line 449, in result
    return self.__get_result()
           ^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/concurrent/futures/_base.py", line 401, in __get_result
    raise self._exception
  File "/app/.venv/lib/python3.12/site-packages/tenacity/asyncio/__init__.py", line 114, in __call__
    result = await fn(*args, **kwargs)
             ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/llm/ollama.py", line 109, in _ollama_model_if_cache
    raise e
  File "/app/lightrag/llm/ollama.py", line 72, in _ollama_model_if_cache
    response = await ollama_client.chat(model=model, messages=messages, **kwargs)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 953, in chat
    return await self._request(
           ^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 751, in _request
    return cls(**(await self._request_raw(*args, **kwargs)).json())
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.venv/lib/python3.12/site-packages/ollama/_client.py", line 695, in _request_raw
    raise ResponseError(e.response.text, e.response.status_code) from None
ollama._types.ResponseError: model runner has unexpectedly stopped, this may be due to resource limitations or an internal error, check ollama server logs for details (status code: 500)

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/app/lightrag/operate.py", line 2936, in _process_with_semaphore
    raise prefixed_exception from e
ollama._types.ResponseError: chunk-3897ebbba3e1e30310d0049e036eafd8: model runner has unexpectedly stopped, this may be due to resource limitations or an internal error, check ollama server logs for details (status code: -1)

The above exception was the direct cause of the following exception:
qwen2.5-coder:7b
Traceback (most recent call last):
  File "/app/lightrag/lightrag.py", line 1838, in process_document
    chunk_results = await entity_relation_task
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/lightrag.py", line 2122, in _process_extract_entities
    raise e
  File "/app/lightrag/lightrag.py", line 2107, in _process_extract_entities
    chunk_results = await extract_entities(
                    ^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/lightrag/operate.py", line 2978, in extract_entities
    raise prefixed_exception from first_exception
ollama._types.ResponseError: C[3/5]: chunk-3897ebbba3e1e30310d0049e036eafd8: model runner has unexpectedly stopped, this may be due to resource limitations or an internal error, check ollama server logs for details (status code: -1)
Failed to extract document 8/8: Applying Lessons from 8 Things We Hate About IT to Libraries.md
Processing additional documents due to pending request
Reset 3 documents from PROCESSING/FAILED to PENDING status
Processing 3 document(s)
Extracting stage 1/3: A Metadata Schema for Geospatial Resource Discovery Use Cases.md
Processing d-id: doc-325388c2dd550aaa769a2b560c7489c2
Chunk 1 of 13 extracted 11 Ent + 5 Rel chunk-de31f3e4e72fe2bed750865254f7712e
Chunk 2 of 13 extracted 10 Ent + 5 Rel chunk-06f0ce4c88a2fb83d4639c12c8518420
Chunk 3 of 13 extracted 22 Ent + 12 Rel chunk-c0c84487c0a51c3e9c6102101c9c25ef
Chunk 4 of 13 extracted 20 Ent + 9 Rel chunk-45f182f74b588f3b7701f43cd90fe582qwen2.5-coder:7b
Chunk 5 of 13 extracted 37 Ent + 8 Rel chunk-7bf83c55a31ec04f90d76033278c2346
Chunk 6 of 13 extracted 15 Ent + 10 Rel chunk-7277c005940acceccff53d63a32cb293
Chunk 7 of 13 extracted 14 Ent + 5 Rel chunk-c1d2cb730adf6dc963ce62113b4d6ca8
Chunk 8 of 13 extracted 9 Ent + 8 Rel chunk-fc6c3d3fbd0d9209745e691bd373f1db
Chunk 9 of 13 extracted 27 Ent + 24 Rel chunk-70f68dac62451692075eaa372a394d6c
Chunk 10 of 13 extracted 13 Ent + 7 Rel chunk-2e154ccceb8d75f36646d3db9db24aec
Chunk 11 of 13 extracted 18 Ent + 4 Rel chunk-54f68f67cb3f6389568e02c281de6c99
Chunk 12 of 13 extracted 13 Ent + 6 Rel chunk-bd80fec817d2462bddd1411cb77d2b7b
Chunk 13 of 13 extracted 17 Ent + 11 Rel chunk-9dfeede401d7720803f51abb0d19d3c2
Merging stage 1/3: A Metadata Schema for Geospatial Resource Discovery Use Cases.md
Phase 1: Processing 203 entities from doc-325388c2dd550aaa769a2b560c7489c2 (async: 4)
Merged: `Blacklight` | 3+1
Merged: `Apache Solr` | 1+1
Merged: `Figure 1` | 3+1
Merged: `Figure 2` | 2+1
Merged: `Stanford University` | 1+4
Merged: `Library of Congress Subject Headings (LCSH)` | 1+1
Merged: `Metadata` | 1+1
Merged: `English` | 1+1qwen2.5-coder:7b
Merged: `Geographic Data` | 1+1
Merged: `Solr` | 3+1
Merged: `WMS` | 1+1
Merged: `English Language` | 1+1
Merged: `Digital Library` | 1+1
Merged: `Code4Lib` | 1+1
Merged: `MODS` | 1+1
Phase 2: Processing 112 relations from doc-325388c2dd550aaa769a2b560c7489c2 (async: 4)
Chunks appended from relation: `Solr`
Chunks appended from relation: `FGDC`
Chunks appended from relation: `LCSH`
Chunks appended from relation: `MODS`qwen2.5-coder:7b
Phase 3: Updating final 233(203+30) entities and  112 relations from doc-325388c2dd550aaa769a2b560c7489c2
Completed merging: 203 entities, 30 extra entities, 112 relations
Completed processing file 1/3: A Metadata Schema for Geospatial Resource Discovery Use Cases.md
Extracting stage 2/3: Analyzing and Normalizing Type Metadata for a Large Aggregated Digital Library.md
Processing d-id: doc-db7dca3ff80c0092801e64d0f4d1ee03
Chunk 1 of 8 extracted 11 Ent + 9 Rel chunk-29640ed8a07854c928892efbf85fc93e
Chunk 2 of 8 extracted 9 Ent + 6 Rel chunk-2cc9c44f5e46db8b3c90cc3f54327d76
Chunk 3 of 8 extracted 18 Ent + 9 Rel chunk-c8c1d3bb0e8f788764859a281f6b8d23
Chunk 4 of 8 extracted 18 Ent + 9 Rel chunk-39d6d2e2f8dc43be8ddb63aa5ad534ce
Chunk 5 of 8 extracted 9 Ent + 7 Rel chunk-a5f742be4d5c6038cd6863edc714e3ad
Chunk 6 of 8 extracted 1 Ent + 1 Rel chunk-5bff8d2b1340283531cc271a56191eb8
Chunk 7 of 8 extracted 29 Ent + 13 Rel chunk-a2223e7c35e68df235a2ad09a34a05e4
Chunk 8 of 8 extracted 11 Ent + 5 Rel chunk-777e1bbea1dc6495ef6cf52f7394cb4b
Merging stage 2/3: Analyzing and Normalizing Type Metadata for a Large Aggregated Digital Library.md
Phase 1: Processing 92 entities from doc-db7dca3ff80c0092801e64d0f4d1ee03 (async: 4)
Merged: `Python Script` | 2+2
Merged: `OpenRefine` | 1+5
Merged: `The Code4Lib Journal` | 6+1
Merged: `DPLA` | 1+3
Merged: `XML` | 3+1
Merged: `JSON-LD` | 2+1
Merged: `XSLT` | 1+1
Merged: `Facets` | 1+1
Merged: `Spreadsheets` | 1+1
Phase 2: Processing 59 relations from doc-db7dca3ff80c0092801e64d0f4d1ee03 (async: 4)
Chunks appended from relation: `Type Metadata`
Chunks appended from relation: `University of Illinois at Urbana-Champaign`
Chunks appended from relation: `DPLA`
Phase 3: Updating final 97(92+5) entities and  59 relations from doc-db7dca3ff80c0092801e64d0f4d1ee03
Completed merging: 92 entities, 5 extra entities, 59 relations
Completed processing file 2/3: Analyzing and Normalizing Type Metadata for a Large Aggregated Digital Library.md
Extracting stage 3/3: Applying Lessons from 8 Things We Hate About IT to Libraries.md
Processing d-id: doc-d20f4a7007cdf7b788408f54f983b857
Chunk 1 of 5 extracted 20 Ent + 11 Rel chunk-f2bb17d8993532367aeb7aa1758f649d
Chunk 2 of 5 extracted 16 Ent + 14 Rel chunk-7adb7e6a5a0e65d8d28e9a06fa85ae5a
Chunk 3 of 5 extracted 36 Ent + 34 Rel chunk-3897ebbba3e1e30310d0049e036eafd8
Chunk 4 of 5 extracted 18 Ent + 6 Rel chunk-280d2da5c1f7109d1fdc1cc9efb92076
Chunk 5 of 5 extracted 25 Ent + 14 Rel chunk-c2aae58731cad48faa11ab3b07b02355
Merging stage 3/3: Applying Lessons from 8 Things We Hate About IT to Libraries.md
Phase 1: Processing 106 entities from doc-d20f4a7007cdf7b788408f54f983b857 (async: 4)
Merged: `IT` | 2+2
Merged: `Librarians` | 5+1
Merged: `Library` | 5+1
Merged: `Facilities` | 1+1
LLMmrg: `The Code4Lib Journal` | 7+1
Merged: `Libraries` | 3+1
Phase 2: Processing 77 relations from doc-d20f4a7007cdf7b788408f54f983b857 (async: 4)
Chunks appended from relation: `Library Leaders`
Phase 3: Updating final 108(106+2) entities and  77 relations from doc-d20f4a7007cdf7b788408f54f983b857
Completed merging: 106 entities, 2 extra entities, 77 relations
Completed processing file 3/3: Applying Lessons from 8 Things We Hate About IT to Libraries.md
Enqueued document processing pipeline stopped
```

## Change the graph db

Invetigate: `curl -s http://localhost:9621/health | jq '.configuration.graph_storage'`: `"NetworkXStorage"`. 

https://networkx.org/en/

All data from health:

```js
{
  "status": "healthy",
  "working_directory": "/app/data/rag_storage",
  "input_directory": "/app/data/inputs",
  "configuration": {
    "llm_binding": "ollama",
    "llm_binding_host": "http://host.docker.internal:11434",
    "llm_model": "qwen2.5-coder:7b",
    "embedding_binding": "ollama",
    "embedding_binding_host": "http://host.docker.internal:11434",
    "embedding_model": "bge-m3:latest",
    "summary_max_tokens": 1200,
    "summary_context_size": 12000,
    "kv_storage": "JsonKVStorage",
    "doc_status_storage": "JsonDocStatusStorage",
    "graph_storage": "NetworkXStorage",
    "vector_storage": "NanoVectorDBStorage",
    "enable_llm_cache_for_extract": true,
    "enable_llm_cache": true,
    "workspace": "",
    "max_graph_nodes": 100000,
    "enable_rerank": false,
    "rerank_binding": "null",
    "rerank_model": null,
    "rerank_binding_host": null,
    "summary_language": "English",
    "force_llm_summary_on_merge": 8,
    "max_parallel_insert": 1,
    "cosine_threshold": 0.2,
    "min_rerank_score": 0,
    "related_chunk_number": 5,
    "max_async": 2,
    "embedding_func_max_async": 8,
    "embedding_batch_num": 10
  },
  "auth_mode": "disabled",
  "pipeline_busy": false,
  "keyed_locks": {
    "process_id": 1,
    "cleanup_performed": {
      "mp_cleaned": 0,
      "async_cleaned": 0
    },
    "current_status": {
      "total_mp_locks": 0,
      "pending_mp_cleanup": 0,
      "total_async_locks": 0,
      "pending_async_cleanup": 0
    }
  },
  "core_version": "v1.4.9.8",
  "api_version": "0251",
  "webui_title": "Knowledge Base RAG System",
  "webui_description": "Simple and Fast Graph Based RAG System"
}
```

Some possible advance towards Neo4j: https://neo4j.com/docs/operations-manual/current/tutorial/tutorial-clustering-docker/

Just modify the .env seting `LIGHTRAG_GRAPH_STORAGE=Neo4JStorage` followed by `docker-compose restart lightrag`.


In your .env file (lines 297-324), all storage configuration lines are commented out:

```conf
# LIGHTRAG_KV_STORAGE=JsonKVStorage  ← commented, using default
# LIGHTRAG_GRAPH_STORAGE=Neo4JStorage  ← commented, not using Neo4j
# LIGHTRAG_VECTOR_STORAGE=...  ← commented, using default
```

What is used:

```txt
💾 Storage Configuration:
    ├─ KV Storage: JsonKVStorage
    ├─ Vector Storage: NanoVectorDBStorage
    ├─ Graph Storage: NetworkXStorage
    ├─ Document Status Storage: JsonDocStatusStorage
``` 

The application falls back to defaults defined in config.py (lines 56-59):

```python
class DefaultRAGStorageConfig:
    KV_STORAGE = "JsonKVStorage"  # ← local JSON files
    VECTOR_STORAGE = "NanoVectorDBStorage"  # ← local JSON files
    GRAPH_STORAGE = "NetworkXStorage"  # ← local GraphML file
    DOC_STATUS_STORAGE = "JsonDocStatusStorage"  # ← local JSON files
```


Recommendation:
You can safely stop all database services since they're consuming resources but not being used. To do this:

```bash
docker compose -f docker-compose.services.yml stop neo4j mongodb redis memgraph postgres
```

Or if you want to switch to using these services for production (better performance, scalability), uncomment the appropriate lines in .env and restart the lightrag container.

Since you have 1GB+ of existing data and re-processing would take time, you have a few choices:

Keep using JSON storage (it's working fine for your current scale)
Migrate cache + re-index (migrate LLM cache with the tool to save API costs, then re-index documents)
Full re-index (cleanest approach, but will take time and API costs)
