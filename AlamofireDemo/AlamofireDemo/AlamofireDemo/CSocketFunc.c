//
//  CSocketFunc.c
//  AlamofireDemo
//
//  Created by Alexcai on 2018/4/30.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <netdb.h>
#include <string.h>

void test(){
    printf("hello c");
}

int socket_connect(const char * host,int port){
    struct sockaddr_in sa;
    struct hostent *ht;
    int socketfd = -1;
    ht = gethostbyname(host);
    if (ht == NULL) {
        return  socketfd;
    }

    bcopy((char *)ht->h_addr,&sa.sin_addr,ht->h_length);
    sa.sin_family = ht->h_addrtype;
    sa.sin_port = htons(port);
    socketfd = socket(ht->h_addrtype, SOCK_STREAM, IPPROTO_TCP);
    return connect(socketfd, (struct sockaddr *)&sa, sizeof(sa));
}
