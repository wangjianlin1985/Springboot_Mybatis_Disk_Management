package com.zhazhapan.efo.annotation;

import com.zhazhapan.efo.enums.InterceptorLevel;

import java.lang.annotation.*;

/**
 * @author admin
 * @since 2019/12/25
 */
@Documented
@Target({ElementType.TYPE, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface AuthInterceptor {

    /**
     * 定义拦截级别，默认为用户级别拦截
     *
     * @return {@link InterceptorLevel}
     */
    InterceptorLevel value() default InterceptorLevel.USER;
}
