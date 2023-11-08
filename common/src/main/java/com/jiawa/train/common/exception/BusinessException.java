package com.jiawa.train.common.exception;

import lombok.Getter;
import lombok.Setter;

@Getter
public class BusinessException extends RuntimeException{

    private final EBusinessException anEnum;

    public BusinessException(EBusinessException anEnum) {
        this.anEnum = anEnum;
    }
}
