package com.shinhan.page;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ItemPageMaker {
	// 파라미터를 받아서 페이지네이션 버튼을 만든다
	
	private int total_count;
	private int start_page;
	private int end_page;
	private boolean prev;
	private boolean next;
	private int display_page_num=10;
	private ItemCriteria cri;
	
	public void setTotal_count(int total_count) {
		this.total_count=total_count;
		calcData();
	}
	
	private void calcData() {
		end_page = (int) (Math.ceil(cri.getPage() / (double)display_page_num) * display_page_num);
		start_page = (end_page - display_page_num) + 1;
	  
		int temp_end_page = (int) (Math.ceil(total_count / (double)cri.getPer_page_num()));
		if (end_page > temp_end_page) {
			end_page = temp_end_page;
		}
		prev = start_page == 1 ? false : true;
		next = end_page * cri.getPer_page_num() >= total_count ? false : true;
	}
	
	public String makeQuery(int page) {
		UriComponents uriComponents =
		UriComponentsBuilder.newInstance()
						    .queryParam("page", page)
							.queryParam("per_page_num", cri.getPer_page_num())
							.queryParam("store_id", cri.getStore_id())
							.queryParam("category", cri.getCategory())
							.queryParam("sort", cri.getSort())
							.build();
		   
		return uriComponents.toUriString();
	}
	
	public String makeOrderQuery(int page) {
		UriComponents uriComponents =
		UriComponentsBuilder.newInstance()
						    .queryParam("page", page)
							.queryParam("per_page_num", cri.getPer_page_num())
							.queryParam("delivstate", cri.getCategory())
							.build();
		   
		return uriComponents.toUriString();
	}
}
