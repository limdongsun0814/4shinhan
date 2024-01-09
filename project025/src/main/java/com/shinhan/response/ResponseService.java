package com.shinhan.response;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ResponseService {
	
    public <T> SingleResult<T> getSingleResult(T data) {
        SingleResult<T> result = new SingleResult<>();
        result.setData(data);
        setSuccessResult(result);
        return result;
    }

    public Result getSuccessResult() {
        Result result = new Result();
        setSuccessResult(result);
        return result;
    }

    private <T> void setSuccessResult(Result result) {
        result.setSuccess(true);
        result.setCode(0);
        result.setMessage("success");
    }

    public <T> ListResult<T> getListResult(List<T> list) {
        ListResult<T> result = new ListResult<>();
        result.setData(list);
        result.setHasNext(false);
        setSuccessResult(result);
        return result;
    }

    public <T> ListResult<T> getListResult(List<T> list, boolean hasNext) {
        ListResult<T> result = new ListResult<>();
        result.setData(list);
        result.setHasNext(hasNext);
        setSuccessResult(result);
        return result;
    }
}
