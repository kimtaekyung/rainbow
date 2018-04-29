package com.rainbow.util;

import java.util.HashMap;

public class QuerystringPageing {
	
	int total;
	int total_page;
	int curr_page;
	int row = 10;
	int page_row = 5;
	
	/**
	 * non querystring paging
	 * @param total - 총 레코드갯수
	 * @param curr_page - 현재 페이지
	 */
	public QuerystringPageing(int total, int curr_page) {
		this.total = total;
		this.curr_page = curr_page;
		this.total_page = (int) Math.ceil(total/this.row);
	}
	
	/**
	 * non querystring paging
	 * @param total - 총 레코드갯수
	 * @param curr_page - 현재 페이지
	 * @param row - 화면상 디스플레이될 레코드의 수
	 */
	public QuerystringPageing(int total, int curr_page, int row) {
		this.total = total;
		this.curr_page = curr_page;
		this.row = row;
		this.total_page = (int) Math.ceil(( double )total/( double )row);
		
		if(this.curr_page > this.total_page) this.curr_page = this.total_page;
	}
	
	/**
	 * non querystring paging
	 * @param total - 총 레코드갯수
	 * @param curr_page - 현재 페이지
	 * @param row - 화면상 디스플레이될 레코드의 수
	 * @param page_row - 화면상 디스플레이 될 페이지 네비게이션 갯수
	 */
	public QuerystringPageing(int total, int curr_page, int row, int page_row) {
		this.total = total;
		this.curr_page = curr_page;
		this.row = row;
		this.total_page = (int) Math.ceil(( double )total/( double )row);
		this.page_row = page_row;
		
		if(this.curr_page > this.total_page) this.curr_page = this.total_page;
	}
	
	/**
	 * DB limit용 변수와 총 페이지수 반환
	 * @return HashMap<String, Object>
	 * @return start - mysql limit 시작row
	 * @return end - mysql limit offset
	 * @return total_page - 총 페이지 갯수
	 */
	public HashMap<String, Object> getLimit(){
		int rs_start = row*(this.curr_page-1);
		HashMap<String, Object> param = new HashMap<String, Object>();
		if(rs_start < 0)rs_start = 0;
		param.put("start", rs_start);
		param.put("end", this.row);
		param.put("total_page", this.total_page);
		param.put("curr_page", this.curr_page);
		return param;		
	}
	
	/**
	 * jsp용 페이지 네비게이션 반환
	 * @param formId jsp상 기술된 리스트의 form id
	 * @return String
	 */
	public String getScript(String formId){
		String script = "";
		int page_group_no = (this.curr_page-1)/this.page_row;
		int total_group_no = ((int)(Math.ceil((double)(this.total_page)/this.page_row)) - 1);
		int start = page_group_no*this.page_row;
		int end = start+this.page_row;
		int last_page = 0;
		script += "<td align='center' class='paginate'>";
		
		if(page_group_no>0){
			script +=		"	<a href='javascript:go_page(1);' class='pre'>처음</a>";			
			script +=		"	<a href='javascript:go_page("+((page_group_no-1)*this.page_row+1)+");' class='pre'>이전</a>";
		}

		for(int i=start;i<end;i++){
			if(i==this.total_page)break;
			int ii = i+1;
			String cls = "";
			if(ii==this.curr_page) {
				script +=		"	<strong>" + ii + "</strong>";
			}else{
				script +=		"	<a href='javascript:go_page("+ii+");' "+cls+">"+ii+"</a>";
			}
			
		}
		
		if(page_group_no<total_group_no){
			script +=		"	<a href='javascript:go_page("+((page_group_no+1)*this.page_row+1)+");' class='next'>다음</a>";			
			script +=		"	<a href='javascript:go_page("+((total_group_no)*this.page_row+1)+");' class='next'>끝</a>";
		}
		
		script +=		"</td>";
		
		script +=		"<script>";
		script +=		"function go_page(page){";
		script +=		"	$('#page').val(page);";
		script +=		"	$('#"+formId+"').submit();";
		script +=		"}";
		script +=		"</script>";
								
		return script;
	}
}