import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

final List<Map<String, dynamic>> dummyProjects = [
  {
    "id": "proj1",
    "name": "Mangrove Restoration",
    "credits": 1200,
    "location": "Andhra Pradesh",
    "verified": true
  },
  {
    "id": "proj2",
    "name": "Seagrass Plantation",
    "credits": 800,
    "location": "Tamil Nadu",
    "verified": true
  }
];

Response mintCredit(Request req) async {
  final payload = await req.readAsString();
  final data = jsonDecode(payload);
  // Simulate minting
  return Response.ok(jsonEncode({
    "status": "success",
    "txHash": "0x123456789abcdef",
    "creditsMinted": data['amount']
  }));
}

void main() async {
  final handler = Pipeline().addMiddleware(logRequests()).addHandler((Request req) {
    if (req.url.path == 'projects') {
      return Response.ok(jsonEncode(dummyProjects));
    }
    if (req.url.path == 'admin/projects') {
      // Return all projects for admin
      return Response.ok(jsonEncode(dummyProjects));
    }
    if (req.url.path == 'mint-credit' && req.method == 'POST') {
      return mintCredit(req);
    }
    return Response.notFound('Not Found');
  });

  await io.serve(handler, 'localhost', 8080);
  print('Backend running on http://localhost:8080');
}