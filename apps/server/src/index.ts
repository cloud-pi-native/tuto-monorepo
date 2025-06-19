const CORS_HEADERS = {
  headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'OPTIONS, POST',
      'Access-Control-Allow-Headers': 'Content-Type, Authorization',
  },
}

const server = Bun.serve({
  port: 8081,
  fetch(request) {
    console.log(`Received request: ${request.method} ${request.url}`)
    return new Response(JSON.stringify({ docUrl: 'https://cloud-pi-native.fr', githubUrl: 'https://github.com/cloud-pi-native' }), CORS_HEADERS)
  },
})

console.log(`Listening on ${server.url}`)
