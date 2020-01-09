<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<!-- table_area -->
<div class="table_area">
	<table class="list">
		<caption>등록 / 수정 화면</caption>
		<colgroup>
			<col style="width: 20%;">
			<col style="width: *;">
			<col style="width: 20%;">
			<col style="width: 10%;">
		</colgroup>
		<thead>
		<tr>
			<th scope="col" class="first">년도</th>
			<th scope="col">후원금액(원)</th>
			<th scope="col">사용여부</th>
			<th scope="col" class="last">삭제</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td class="first">
				<label for="label01_01" class="hidden">년도</label>
				<select id="label01_01" class="in_wp120">
					<option>2017년</option>
				</select>
			</td>
			<td>
				<label for="label01_02" class="hidden">후원금액(원)</label>
				<input id="label01_02" type="text" class="in_w80"/>
			</td>
			<td>
				<input id="label01_03_01" type="radio" name="label01_03" checked="checked"/>
				<label for="label01_03_01" class="marginr10">사용</label>
				<input id="label01_03_02" type="radio" name="label01_03" />
				<label for="label01_03_02">미사용</label>
			</td>
			<td class="last">
				<button title="취소 하기" class="btn active">
					<span>취소</span>
				</button>
				<!--
                버튼은 둘중 하나만 표시됩니다.
                <button title="삭제하기" class="btn look">
                    <span>삭제</span>
                </button>
                -->
			</td>
		</tr>
		<tr>
			<td class="first">
				<label for="label02_01" class="hidden">년도</label>
				<select id="label02_01" class="in_wp120">
					<option>2016년</option>
				</select>
			</td>
			<td>
				<label for="label02_02" class="hidden">후원금액(원)</label>
				<input id="label02_02" type="text" class="in_w80"/>
			</td>
			<td>
				<input id="label02_03_01" type="radio" name="label02_03" checked="checked"/>
				<label for="label02_03_01" class="marginr10">사용</label>
				<input id="label02_03_02" type="radio" name="label01_03" />
				<label for="label02_03_02">미사용</label>
			</td>
			<td class="last">
				<!--
                버튼은 둘중 하나만 표시됩니다.
                <button title="취소 하기" class="btn active">
                    <span>취소</span>
                </button>
                -->
				<button title="삭제하기" class="btn look">
					<span>삭제</span>
				</button>
			</td>
		</tr>
		</tbody>
	</table>
</div>
<!--// table_area -->

<!-- button_area -->
<div class="button_area">
	<div class="float_right">
		<button class="btn save" title="저장하기">
			<span>저장</span>
		</button>
	</div>
</div>