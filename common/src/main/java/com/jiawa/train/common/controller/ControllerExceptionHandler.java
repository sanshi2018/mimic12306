package com.jiawa.train.common.controller;

import com.jiawa.train.common.exception.BusinessException;
import com.jiawa.train.common.resp.CommonResp;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 使用拦截器统一处理异常
 */
@Slf4j
@ControllerAdvice
public class ControllerExceptionHandler {

    /**
     * 所有异常统一处理
     * @param e 异常
     * @return CommonResp
     */
    @ExceptionHandler(value = Exception.class)
    @ResponseBody
    public CommonResp<Object> exceptionHandler(Exception e) {
        CommonResp<Object> resp  = new CommonResp<>();
        log.error("Exception: {}", e.getMessage(), e);
        resp.setSuccess(false);
        resp.setMessage("系统异常，请联系管理员！");
        return resp;
    }

    /**
     * 业务异常统一处理
     * @param e 业务异常
     * @return CommonResp
     */
    @ExceptionHandler(value = BusinessException.class)
    @ResponseBody
    public CommonResp<Object> exceptionHandler(BusinessException e) {
        CommonResp<Object> resp  = new CommonResp<>();
        log.warn("业务拦截: {}", e.getAnEnum().getDesc());
        resp.setSuccess(false);
        resp.setMessage(e.getAnEnum().getDesc());
        return resp;
    }
}
