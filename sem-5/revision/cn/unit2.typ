// unit2.typ: Unit 2 - Software Application Layer
#import "theme.typ": *

#unit-header(
  "2",
  "Software Application Layer",
  "Network application architectures, web protocols (HTTP/1.0 through HTTP/3), email systems, DNS namespace resolution, and socket programming.",
  checklist: (
    "Client-Server vs. Peer-to-Peer (P2P)",
    "HTTP Evolution: 1.0, 1.1, 2.0, and 3.0",
    "HTTP Status Codes, Cookies & Web Caching",
    "Email Architecture & Protocols (SMTP, POP3, IMAP)",
    "DNS Server Hierarchy & Query Resolution",
    "Core DNS Resource Record Types (A, MX, etc.)",
    "Socket Abstraction: IP + Port Endpoints",
    "TCP vs. UDP Socket Programming Life Cycles"
  )
)

#extra-pill
= 2.1 Fundamentals of Network Application Architectures

At Layer 7, application software programs execute strictly on end systems at the network edge, communicating over the network via lower-layer services.

== Primary Application Paradigms

- #key-term[Client-Server Architecture:]
  - An asymmetric paradigm where an *always-on host* (the server) with a permanent, globally routable IP address listens continuously for incoming service requests.
  - Senders (*clients*) initiate contact dynamically, often possess transient dynamic IP addresses, and do not communicate directly with other clients.
  - Bottlenecks occur at scale, requiring server virtualization, reverse proxies, and Content Delivery Networks (CDNs).
- #key-term[Peer-to-Peer (P2P) Architecture:]
  - A decentralized paradigm where arbitrary pairs of interconnected hosts (*peers*) communicate directly without passing through a dedicated central server.
  - Highly *self-scalable*: each peer brings service capacity (upload bandwidth) in addition to consuming demand (download bandwidth).
  - Challenges include dynamic peer churn, complex indexing, NAT traversal, and security governance.

== Application Transport Requirements

Applications select underlying transport protocols based on four foundational service dimensions:
1. #key-term[Data Integrity & Loss Tolerance:] Audio/video streaming can tolerate minor packet loss, whereas file transfer (FTP), web browsing (HTTP), and financial transactions require strict 100% loss-free reliable transport (TCP).
2. #key-term[Throughput Guarantee:] Bandwidth-sensitive applications require guaranteed transmission rates (e.g., 5 Mbps for HD video), whereas elastic applications adjust dynamically to whatever throughput is available.
3. #key-term[Timing & Latency Constraints:] Real-time voice (VoIP) and online multiplayer gaming demand tight latency bounds ($< 150 text(" ms")$) to avoid perceptual lag.
4. #key-term[Security & Encryption:] Confidentiality, endpoint authentication, and message integrity provided by transport-layer security (TLS/SSL).

#extra-pill
= 2.2 Web Technologies & The HTTP Protocol

The #key-term[Hypertext Transfer Protocol (HTTP)] is the application-layer foundation of the World Wide Web, operating on a client-server request/response model over TCP (traditionally port 80 for HTTP, port 443 for HTTPS).

== Evolutionary Progression of HTTP

#table(
  columns: (1fr, 1.2fr, 2.8fr),
  fill: (x, y) => if y == 0 { crimson-main } else if calc.even(y) { warm-bg } else { white },
  stroke: 0.5pt + warm-border,
  align: (center, left, left),
  table.header(
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Version],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Transport Model],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Architectural Characteristics & Innovations],
  ),
  [*HTTP/1.0*], [Non-Persistent TCP], [Opens and tears down a brand new TCP connection for every single referenced object. Incurs 2 RTTs + transmission delay per embedded resource.],
  [*HTTP/1.1*], [Persistent TCP], [Maintains a single open TCP connection across multiple object requests. Supports pipelining, chunked transfer, and mandatory `Host` header. Suffers from transport Head-of-Line (HOL) blocking.],
  [*HTTP/2*], [Multiplexed Binary TCP], [Replaces text commands with binary framing. Multiplexes concurrent streams over a single connection, supports stream priorities, server push, and HPACK header compression.],
  [*HTTP/3*], [QUIC (over UDP)], [Replaces TCP with QUIC over UDP. Eliminates transport-layer HOL blocking caused by packet loss; integrates 0-RTT TLS 1.3 handshakes and seamless connection migration across IP changes.],
)

== Standard HTTP Response Status Codes

HTTP response codes inform the client of request execution results:
- #key-term[2xx (Success):] `200 OK` (request succeeded, object delivered); `201 Created` (resource created post-POST); `204 No Content` (success with no response body).
- #key-term[3xx (Redirection):] `301 Moved Permanently` (resource relocated to new URI in `Location` header); `302 Found` (temporary redirect); `304 Not Modified` (client cache is up to date).
- #key-term[4xx (Client Error):] `400 Bad Request` (syntactically invalid request); `401 Unauthorized` (authentication required); `403 Forbidden` (access denied); `404 Not Found` (requested URL does not exist).
- #key-term[5xx (Server Error):] `500 Internal Server Error` (unhandled server exception); `502 Bad Gateway` (invalid response from upstream backend); `503 Service Unavailable` (server overloaded or in maintenance).

== Cookies and Web Caching

- #key-term[Cookies (RFC 6265):] HTTP is fundamentally *stateless*. To maintain user sessions across transactions, servers include a `Set-Cookie: id=xyz` header in the HTTP response. The client browser stores this token locally and includes `Cookie: id=xyz` in subsequent requests, enabling shopping carts, persistent logins, and user tracking.
- #key-term[Web Caching (Proxy Servers):] A web cache retains copies of recently requested objects in local storage. Requests are fulfilled locally without contacting origin servers, reducing access latency and conserving enterprise egress bandwidth. Caches maintain freshness using the *Conditional GET*:

#algorithm-box("Conditional GET Caching Workflow", [
```http
// 1. Client requests object from cache
GET /diagram.png HTTP/1.1
Host: www.example.com

// 2. Cache verifies with origin server if resource has changed since date
GET /diagram.png HTTP/1.1
Host: www.example.com
If-Modified-Since: Sun, 15 Sep 2026 10:00:00 GMT

// 3. Origin server confirms object is unmodified (zero payload overhead)
HTTP/1.1 304 Not Modified
Date: Mon, 21 Sep 2026 02:00:00 GMT
```
])

= 2.3 Email Communication & Protocols

Electronic mail transmission is governed by specialized application protocols that segregate *message pushing* from *mailbox retrieval*.

#figure-card("images/image4.jpg", [End-to-end email transmission pipeline: SMTP pushing messages between servers, POP3/IMAP pulling to user clients.])

== The Email Architecture Pipeline

1. #key-term[User Agents (MUA):] Client mail programs (Thunderbird, Outlook, mobile mail apps) allowing users to compose, format, and read messages.
2. #key-term[Mail Servers (MTA/MDA):] Core infrastructure components maintaining user mailboxes and outgoing spool queues. When an email cannot be immediately delivered, the server holds it in a message queue and retries periodically (typically for 48–72 hours).
3. #key-term[SMTP (Simple Mail Transfer Protocol - RFC 5321):] Operates over TCP port 25 for server-to-server relay and port 587 for authenticated client submission.
   - SMTP is strictly a *push protocol*: it pushes email from sender MUA to the sender's mail server, and across intermediate MTAs to the recipient's mail server.
   - Text-based ASCII dialogue: commands (`EHLO`, `MAIL FROM:`, `RCPT TO:`, `DATA`, `QUIT`) accompanied by 3-digit status codes (`250 OK`, `354 Start Mail Input`, `550 No Such User`).
   - Standard SMTP carries 7-bit ASCII text; non-text binary attachments (PDFs, images) are encoded using *MIME (Multipurpose Internet Mail Extensions)* base64 encoding.

== Mailbox Retrieval: POP3 vs. IMAP

Because destination recipient machines are frequently offline or powered down, emails reside in the destination mail server's storage until pulled by the recipient's client:
- #key-term[POP3 (Post Office Protocol v3 - Port 110):] Extremely simple retrieval protocol operating in "Download-and-Delete" or "Download-and-Keep" mode. Mail is fetched to local client storage. POP3 does not support folder synchronization; actions taken on one client device are not reflected on other devices.
- #key-term[IMAP (Internet Message Access Protocol - Port 143):] Advanced, stateful mailbox management protocol. All messages, folders, and read/unread status flags reside permanently on the mail server. Multiple client devices access synchronized views of the identical mailbox simultaneously.

= 2.4 Domain Name System (DNS) & Domain Resolution

The #key-term[Domain Name System (DNS)] is a globally distributed, hierarchical database translating human-friendly alphanumeric hostnames (e.g., `engineering.university.edu`) into 32-bit IPv4 or 128-bit IPv6 numerical addresses.

#figure-card("images/image10.jpg", [Hierarchical DNS resolution architecture: Root, Top-Level Domain (TLD), and Authoritative name servers.])

== The DNS Server Hierarchy

1. #key-term[Root DNS Servers:] 13 logical root server identities (`a.root-servers.net` to `m.root-servers.net`), operated by 12 independent organizations and replicated worldwide across hundreds of physical locations using *IP Anycast*. Root servers direct queries to Top-Level Domain (TLD) servers.
2. #key-term[Top-Level Domain (TLD) Servers:] Oversee top-level domain zones, partitioned into generic TLDs (`.com`, `.org`, `.edu`, `.net`) managed by entities like VeriSign, and country-code TLDs (`.uk`, `.in`, `.de`, `.jp`).
3. #key-term[Authoritative DNS Servers:] Publicly accessible nameservers maintained by organizations or cloud DNS hosting providers containing the definitive mapping records for all hosts within a domain zone.
4. #key-term[Local DNS Resolvers (Default Nameservers):] Residential ISPs or enterprise networks provide local resolver caches (e.g., `8.8.8.8`, `1.1.1.1`). When a host issues a query, it contacts its local resolver first.

== Iterative vs. Recursive Query Resolution

- #key-term[Recursive Query:] The requesting host places the entire resolution burden on the queried server. The queried server *must* return the definitive answer or an explicit error, issuing queries on the client's behalf.
- #key-term[Iterative Query:] The queried server returns the best answer it currently possesses: either the requested record or the referral IP address of the next server down the hierarchy. The local resolver iteratively follows the referral chain (Root $arrow$ TLD $arrow$ Authoritative).

== Core DNS Resource Records (RR Format: `(Name, Value, Type, TTL)`)

#table(
  columns: (1fr, 1.2fr, 2.8fr),
  fill: (x, y) => if y == 0 { crimson-main } else if calc.even(y) { warm-bg } else { white },
  stroke: 0.5pt + warm-border,
  align: (center, left, left),
  table.header(
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Record Type],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Designation],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Functional Definition & Operational Use Case],
  ),
  [*A*], [IPv4 Host Address], [Maps an alphanumeric hostname directly to a 32-bit IPv4 address (`example.com -> 93.184.216.34`).],
  [*AAAA*], [IPv6 Host Address], [Maps a hostname directly to a 128-bit IPv6 address (`example.com -> 2606:2800:220:1:248:1893:25c8:1946`).],
  [*CNAME*], [Canonical Name], [Defines an alias pointing to the official canonical hostname (`www.example.com -> server1.example.com`).],
  [*NS*], [Name Server], [Designates the authoritative nameserver responsible for a delegated domain zone.],
  [*MX*], [Mail Exchange], [Specifies the destination mail gateway server accepting email for the domain, with numerical priority values.],
  [*TXT*], [Arbitrary Text Data], [Carries machine-readable security records: Sender Policy Framework (SPF), DKIM public keys, and DMARC policies.],
  [*PTR*], [Pointer Record], [Enables Reverse DNS lookup, resolving an IP address back to its associated hostname (under `in-addr.arpa`).],
)

#extra-pill
= 2.5 Client-Server Programming with Sockets

A #key-term[network socket] is the software abstraction and operating-system-managed endpoint through which application processes send and receive data across the network interface ($text("Socket") = text("IP Address") + text("Port Number")$).

== TCP vs. UDP Socket Programming Life Cycles

#table(
  columns: (1.2fr, 1.8fr, 1.8fr),
  fill: (x, y) => if y == 0 { crimson-main } else if calc.even(y) { warm-bg } else { white },
  stroke: 0.5pt + warm-border,
  align: (left, left, left),
  table.header(
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Operational Phase],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[TCP Socket (Stream SOCK_STREAM)],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[UDP Socket (Datagram SOCK_DGRAM)],
  ),
  [*1. Creation*], [`s = socket(AF_INET, SOCK_STREAM)`], [`s = socket(AF_INET, SOCK_DGRAM)`],
  [*2. Server Setup*], [`bind()` socket to local port, followed by `listen()` to queue incoming connections], [`bind()` socket to local port; no `listen()` state needed],
  [*3. Connection*], [Client calls `connect()`; server accepts via `conn, addr = accept()`, creating a *dedicated connection socket*], [No connection handshake; server and client communicate directly via stateless datagrams],
  [*4. Data Transfer*], [Continuous byte stream transfer: `send()` / `recv()`; handles sequence reordering and retransmissions], [Discrete datagram boundaries: `sendto(data, (ip, port))` and `recvfrom(bufsize)`],
  [*5. Teardown*], [Orderly 4-way FIN/ACK disconnection: `close()`], [Immediate endpoint release: `close()`],
)

#callout-box(title: "Welcoming Socket vs. Connection Socket in TCP Servers")[
  A TCP server maintains a permanent *Welcoming (Listening) Socket* bound to its well-known port (e.g., 80). When a new client arrives, `accept()` returns a brand new *Connection Socket* uniquely tied to that client's 4-tuple. This leaves the welcoming socket free to listen for new incoming connections.
]
