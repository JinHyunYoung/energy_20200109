<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
</script>


					<div class="sub_content">
						<div class="dictionary_search_area">
							<div class="dictionary_search_input">
								<strong>용어검색</strong>
								<input type="text" name="dic_keyword" id="dic_keyword" class="" placeholder="검색어를 입력하세요." style="height:33px;" value="${param.dic_keyword}" maxlength="50" />
								<label for="dic_keyword" class="hidden">검색어</label>
								<button title="검색하기" class="btn dic_sch" onclick="search();">
									<span>검색하기</span>
								</button>
							</div>
							<ul class="dictionary_recommend_list">
								
								<c:forEach items="${top5}" var="term">
								<li>
									<a href="#" title="${term.sch_term} 검색">${term.sch_term}</a>
								</li>
								</c:forEach>							
							</ul>
						</div>
						<div class="dictionary_keyword_area">
							<div class="dictionary_keyword_ver01">
								<strong><span>가나다</span> 순</strong>
								<ul class="dictionary_keyword_list">
									<li <c:if test="${param.kr_idx == 'ㄱ'}">class="on"</c:if>>
										<a href="#ㄱ"  title="ㄱ으로 찾기">
											<span>ㄱ</span>
										</a>
									</li>
									<li <c:if test="${param.kr_idx == 'ㄴ'}">class="on"</c:if>>
										<a href="#" title="ㄴ으로 찾기">
											<span>ㄴ</span>
										</a>
									</li>
									<li <c:if test="${param.kr_idx == 'ㄷ'}">class="on"</c:if>>
										<a href="#" title="ㄷ으로 찾기">
											<span>ㄷ</span>
										</a>
									</li>
									<li <c:if test="${param.kr_idx == 'ㄹ'}">class="on"</c:if>>
										<a href="#" title="ㄹ으로 찾기">
											<span>ㄹ</span>
										</a>
									</li>
									<li <c:if test="${param.kr_idx == 'ㅁ'}">class="on"</c:if>>
										<a href="#" title="ㅁ으로 찾기">
											<span>ㅁ</span>
										</a>
									</li>
									<li <c:if test="${param.kr_idx == 'ㅂ'}">class="on"</c:if>>
										<a href="#" title="ㅂ으로 찾기">
											<span>ㅂ</span>
										</a>
									</li>
									<li <c:if test="${param.kr_idx == 'ㅅ'}">class="on"</c:if>>
										<a href="#" title="ㅅ으로 찾기">
											<span>ㅅ</span>
										</a>
									</li>
									<li <c:if test="${param.kr_idx == 'ㅇ'}">class="on"</c:if>>
										<a href="#" title="ㅇ으로 찾기">
											<span>ㅇ</span>
										</a>
									</li>
									<li <c:if test="${param.kr_idx == 'ㅈ'}">class="on"</c:if>>
										<a href="#" title="ㅈ으로 찾기">
											<span>ㅈ</span>
										</a>
									</li>
									<li <c:if test="${param.kr_idx == 'ㅊ'}">class="on"</c:if>>
										<a href="#" title="ㅊ으로 찾기">
											<span>ㅊ</span>
										</a>
									</li>
									<li <c:if test="${param.kr_idx == 'ㅋ'}">class="on"</c:if>>
										<a href="#" title="ㅋ으로 찾기">
											<span>ㅋ</span>
										</a>
									</li>
									<li <c:if test="${param.kr_idx == 'ㅌ'}">class="on"</c:if>>
										<a href="#" title="ㅌ으로 찾기">
											<span>ㅌ</span>
										</a>
									</li>
									<li <c:if test="${param.kr_idx == 'ㅍ'}">class="on"</c:if>>
										<a href="#" title="ㅍ으로 찾기">
											<span>ㅍ</span>
										</a>
									</li>
									<li <c:if test="${param.kr_idx == 'ㅎ'}">class="on"</c:if>>
										<a href="#" title="ㅎ으로 찾기">
											<span>ㅎ</span>
										</a>
									</li>
								</ul>
							</div>
							<div>
								<strong><span>알파벳</span> 순</strong>
								<ul class="dictionary_keyword_list_en">
									<li <c:if test="${param.en_idx == 'A'}">class="on"</c:if>>
										<a href="#" title="A로 찾기">
											<span>A</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'B'}">class="on"</c:if>>
										<a href="#" title="B로 찾기">
											<span>B</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'C'}">class="on"</c:if>>
										<a href="#" title="C로 찾기">
											<span>C</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'D'}">class="on"</c:if>>
										<a href="#" title="D로 찾기">
											<span>D</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'E'}">class="on"</c:if>>
										<a href="#" title="E로 찾기">
											<span>E</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'F'}">class="on"</c:if>>
										<a href="#" title="F로 찾기">
											<span>F</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'G'}">class="on"</c:if>>
										<a href="#" title="G로 찾기">
											<span>G</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'H'}">class="on"</c:if>>
										<a href="#" title="H로 찾기">
											<span>H</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'I'}">class="on"</c:if>>
										<a href="#" title="I로 찾기">
											<span>I</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'J'}">class="on"</c:if>>
										<a href="#" title="J로 찾기">
											<span>J</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'K'}">class="on"</c:if>>
										<a href="#" title="K로 찾기">
											<span>K</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'L'}">class="on"</c:if>>
										<a href="#" title="L로 찾기">
											<span>L</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'M'}">class="on"</c:if>>
										<a href="#" title="M로 찾기">
											<span>M</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'N'}">class="on"</c:if>>
										<a href="#" title="N로 찾기">
											<span>N</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'O'}">class="on"</c:if>>
										<a href="#" title="O로 찾기">
											<span>O</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'P'}">class="on"</c:if>>
										<a href="#" title="A로 찾기">
											<span>P</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'R'}">class="on"</c:if>>
										<a href="#" title="R로 찾기">
											<span>R</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'S'}">class="on"</c:if>>
										<a href="#" title="S로 찾기">
											<span>S</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'T'}">class="on"</c:if>>
										<a href="#" title="T로 찾기">
											<span>T</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'U'}">class="on"</c:if>>
										<a href="#" title="U로 찾기">
											<span>U</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'V'}">class="on"</c:if>>
										<a href="#" title="V로 찾기">
											<span>V</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'W'}">class="on"</c:if>>
										<a href="#" title="W로 찾기">
											<span>W</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'X'}">class="on"</c:if>>
										<a href="#" title="X로 찾기">
											<span>X</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'Y'}">class="on"</c:if>>
										<a href="#" title="Y로 찾기">
											<span>Y</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'Z'}">class="on"</c:if>>
										<a href="#" title="Z로 찾기">
											<span>Z</span>
										</a>
									</li>
									<li <c:if test="${param.en_idx == 'etc'}">class="on"</c:if>>
										<a href="#" title="etc로 찾기">
											<span>etc</span>
										</a>
									</li>
								</ul>
							</div>
						</div>
						<!-- 
						<div class="dictionary_area_01">
							<p>물산업 용어사전은 물산업관련 새롭거나 이슈가 되는 용어를 알기 쉽고 체계적으로 제공합니다.</p>
						</div>
						 -->
						<div class="dictionary_area_02">
							<p class="dic_sch_result"><c:if test="${not empty param.dic_keyword}">“<span class="dic_keyword">${param.dic_keyword}</span>”에 대한 </c:if>총 <span class="dic_count">${totalcnt}</span>개의 용어가 검색되었습니다.</p>							
							<ul >
							<c:forEach items="${dictionaryList}" var="dictionary">
								<li>
								<c:if test="${empty dictionary.term_en_nm}" >
									<strong>${dictionary.term_kr_nm} </strong>
								</c:if>
								<c:if test="${not empty dictionary.term_en_nm}" >
									<strong>${dictionary.term_kr_nm} | ${dictionary.term_en_nm}</strong>
								</c:if>
									<p>${dictionary.term_dfn}</p>
								</li>		
							</c:forEach>
							</ul>
							<!-- paging_area -->
				            ${dictionaryPagging}
				            <!--// paging_area -->
						</div>						
					</div>
					
