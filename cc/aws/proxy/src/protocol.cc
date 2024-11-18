// Copyright 2022 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "proxy/src/protocol.h"

#include <errno.h>
#include <limits.h>
#include <stdlib.h>
#include <string.h>

// For both request and response the ATYP is byte 3, followed by the address and
// port.
// Request:
//    +----+-----+-------+------+----------+----------+
//    |VER | CMD |  RSV  | ATYP | DST.ADDR | DST.PORT |
//    +----+-----+-------+------+----------+----------+
//    | 1  |  1  | X'00' |  1   | Variable |    2     |
//    +----+-----+-------+------+----------+----------+
// Response:
//    +----+-----+-------+------+----------+----------+
//    |VER | REP |  RSV  | ATYP | BND.ADDR | BND.PORT |
//    +----+-----+-------+------+----------+----------+
//    | 1  |  1  | X'00' |  1   | Variable |    2     |
//    +----+-----+-------+------+----------+----------+
static constexpr uint8_t kATYP_v4 = 0x01;
static constexpr uint8_t kATYP_v6 = 0x04;

size_t FillAddrPort(void* msg, const sockaddr* addr) {
  uint8_t* buf = reinterpret_cast<uint8_t*>(msg);
  if (addr->sa_family == AF_INET) {
    buf[0] = kATYP_v4;
    const sockaddr_in* v4addr = reinterpret_cast<const sockaddr_in*>(addr);
    // V4 address is for sure 4 bytes.
    memcpy(&buf[1], &v4addr->sin_addr, sizeof(v4addr->sin_addr));
    // V4 address is for sure 2 bytes.
    memcpy(&buf[1 + sizeof(v4addr->sin_addr)], &v4addr->sin_port,
           sizeof(v4addr->sin_port));
    return 1LU + sizeof(v4addr->sin_addr) + sizeof(v4addr->sin_port);  // ==7
  } else if (addr->sa_family == AF_INET6) {
    buf[0] = kATYP_v6;
    const sockaddr_in6* v6addr = reinterpret_cast<const sockaddr_in6*>(addr);
    // V6 address is for sure 16 bytes.
    memcpy(&buf[1], &v6addr->sin6_addr, sizeof(v6addr->sin6_addr));
    // V6 port is for sure 2 bytes.
    memcpy(&buf[1 + sizeof(v6addr->sin6_addr)], &v6addr->sin6_port,
           sizeof(v6addr->sin6_port));
    return 1LU + sizeof(v6addr->sin6_addr) + sizeof(v6addr->sin6_port);  // ==19
  } else {
    return 0;
  }
}

// Construct a sockaddr of the parent instance by looking and env variables, or
// default if env not set.
sockaddr_vm GetProxyVsockAddr() {
  unsigned int cid = kDefaultParentCid;
  unsigned int port = kDefaultParentPort;
  EnvGetVal(kParentCidEnv, cid);
  EnvGetVal(kParentPortEnv, port);

  sockaddr_vm addr;
  memset(&addr, 0, sizeof(addr));
  addr.svm_family = AF_VSOCK;
  addr.svm_port = port;
  addr.svm_cid = cid;
  return addr;
}

void EnvGetVal(const char* env_name, unsigned int& val) {
  if (env_name == nullptr) {
    return;
  }
  char* val_str = getenv(env_name);
  if (val_str == nullptr) {
    return;
  }
  errno = 0;
  char* end;
  unsigned int v = strtoul(val_str, &end, 10);
  if (errno == 0 && v < UINT_MAX) {
    val = static_cast<unsigned int>(v);
  }
}
