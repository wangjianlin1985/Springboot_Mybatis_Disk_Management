package com.zhazhapan.efo.service;

import org.springframework.web.multipart.MultipartFile;

/**
 * @author admin
 * @since 2019/12/23
 */
public interface ICommonService {

    /**
     * 发送验证码
     *
     * @param email 邮箱
     *
     * @return 验证码
     */
    int sendVerifyCode(String email);

    /**
     * 上传头像
     *
     * @param multipartFile 头像文件
     *
     * @return 头像文件名
     */
    String uploadAvatar(MultipartFile multipartFile);
}
