package com.jiawa.train.common.interceptor;

import lombok.extern.slf4j.Slf4j;
import okhttp3.Interceptor;
import okhttp3.Response;
import org.jetbrains.annotations.NotNull;

import java.io.IOException;

@Slf4j
public class OkHttpInterceptor implements Interceptor {
    @NotNull
    @Override
    public Response intercept(@NotNull Chain chain) throws IOException {
        log.info("okHttp method: {}", chain.request().method());
        log.info("okHttp request: {}", chain.request().body());
        return chain.proceed(chain.request());
    }
}
