package com.jiawa.train.common.interceptor;

import feign.InvocationContext;
import feign.ResponseInterceptor;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;

@Slf4j
public class OkHttpResqInterceptor implements ResponseInterceptor {
    @Override
    public Object aroundDecode(InvocationContext invocationContext) throws IOException {
        log.info("进入okhttp响应拦截器");
        return invocationContext.proceed();
    }
}
