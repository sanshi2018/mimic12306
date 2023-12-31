package com.jiawa.train.common.resp;

import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
public class CommonResp<T> {
    /**
     * 业务上的成功或失败
     */
    private boolean success = true;

    /**
     * 返回信息
     */
    private String message;

    /**
     * 返回泛型数据，自定义类型
     */
    private T content;

    public CommonResp() {
    }

    public CommonResp(T content) {
        this.content = content;
    }

    public CommonResp<T> success(T content) {
        this.setSuccess(true);
        this.setContent(content);
        return this;
    }

    @Override
    public String toString() {
        final StringBuffer sb = new StringBuffer("CommonResp{");
        sb.append("success=").append(success);
        sb.append(", message='").append(message).append('\'');
        sb.append(", content=").append(content);
        sb.append('}');
        return sb.toString();
    }
}
