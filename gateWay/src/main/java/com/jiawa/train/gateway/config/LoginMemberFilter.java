package com.jiawa.train.gateway.config;

import cn.hutool.json.JSONUtil;
import com.jiawa.train.common.resp.CommonResp;
import com.jiawa.train.common.util.JwtUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

@Slf4j
@Component
public class LoginMemberFilter implements GlobalFilter, Ordered {

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        // 检查http请求head中是否带有token
        String path = exchange.getRequest().getURI().getPath();
        if (path.contains("/admin")
                || path.contains("/hello")
                || path.contains("/member/member/login")
                || path.contains("/member/member/send-code")) {
            log.info("不需要登录验证");
            return chain.filter(exchange);
        }

        String token = exchange.getRequest().getHeaders().getFirst("token");
        // 检验token是否有效，是否过期
        if (!JwtUtil.validate(token)) {

            ServerHttpResponse response = exchange.getResponse();
            exchange.getResponse().setStatusCode(HttpStatus.OK);
            response.getHeaders().add("Content-Type", "application/json;charset=UTF-8");

            CommonResp resp = new CommonResp();
            resp.setSuccess(false);
            resp.setMessage("token无效，请重新登陆");
            return response.writeWith(Mono.just(response
                    .bufferFactory().wrap(JSONUtil.toJsonStr(resp).getBytes())));
        }
        return chain.filter(exchange);

    }

    @Override
    public int getOrder() {
        return 0;
    }
}
