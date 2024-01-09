package com.shinhan.response;

import lombok.Data;

@Data
public class SingleResult<T> extends Result {
    private T data;
}