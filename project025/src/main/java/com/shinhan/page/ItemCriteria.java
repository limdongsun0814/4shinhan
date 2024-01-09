package com.shinhan.page;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ItemCriteria {
	
	private int page;	// 현재 페이지 수
	private int per_page_num;	// 출력할 개수
	private int row_start;	// 출력 시작 번호
	private int row_end;	// 출력 끝 번호
	private int store_id;
	private String category;
	private String sort;
	
	public ItemCriteria() {
		// 1페이지에 9개 값 출력
		this.page=1;
		this.per_page_num=9;
	}
	
	public void setPage(int page) {
		if(page<=0) {
			this.page=1;
			return;
		}
		this.page=page;
	}
	
	public void setPer_page_num(int per_page_num) {
		if (per_page_num<=0 || per_page_num>100) {
			this.per_page_num=9;
			return;
		}
		this.per_page_num=per_page_num;
	}
	
	public int getPage_start() {
		return (this.page-1)*this.per_page_num;
	}
	
	public int getRow_start() {
		this.row_start=((this.page-1)*this.per_page_num)+1;
		return this.row_start;
	}
	
	public int getRow_end() {
		this.row_end=this.row_start+this.per_page_num-1;
		return this.row_end;
	}
}
