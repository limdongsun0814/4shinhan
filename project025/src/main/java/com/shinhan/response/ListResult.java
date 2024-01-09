package com.shinhan.response;

import java.util.List;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class ListResult<T> extends Result {
    private List<T> data;
    private boolean hasNext;
}