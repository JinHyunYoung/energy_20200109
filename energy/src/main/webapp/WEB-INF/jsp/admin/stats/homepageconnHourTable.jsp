<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

		<!-- table 1dan list -->
		<div class="table_area">
		
			<table id="insurance_tb" class="list fixed">
				<caption>시간대별 방문통계</caption>
				<colgroup>
					<col style="width: 33%;" />
					<col style="width: 33%;" />
					<col style="width: 34%" />
				</colgroup>
				<thead>
				<tr>
					<th class="first" scope="col">시간대</th>
					<th scope="col">방문자(명)</th>
					<th class="last" scope="col">점유율(%)</th>
				</tr>
				</thead>
				<tbody>
					<tr>
						<td class="first alignc">00:00 ~ 01:00</td>
						<td class="alignc">${connhour.h00}</td>
						<td class="last alignc">${connhour.ha00}</td>
					</tr>
					<tr>
						<td class="first alignc">01:00 ~ 02:00</td>
						<td class="alignc">${connhour.h01}</td>
						<td class="last alignc">${connhour.ha01}</td>
					</tr>
					<tr>
						<td class="first alignc">02:00 ~ 03:00</td>
						<td class="alignc">${connhour.h02}</td>
						<td class="last alignc">${connhour.ha02}</td>
					</tr>
					<tr>
						<td class="first alignc">03:00 ~ 04:00</td>
						<td class="alignc">${connhour.h03}</td>
						<td class="last alignc">${connhour.ha03}</td>
					</tr>
					<tr>
						<td class="first alignc">04:00 ~ 05:00</td>
						<td class="alignc">${connhour.h04}</td>
						<td class="last alignc">${connhour.ha04}</td>
					</tr>
					<tr>
						<td class="first alignc">05:00 ~ 06:00</td>
						<td class="alignc">${connhour.h05}</td>
						<td class="last alignc">${connhour.ha05}</td>
					</tr>
					<tr>
						<td class="first alignc">06:00 ~ 07:00</td>
						<td class="alignc">${connhour.h06}</td>
						<td class="last alignc">${connhour.ha06}</td>
					</tr>
					<tr>
						<td class="first alignc">07:00 ~ 08:00</td>
						<td class="alignc">${connhour.h07}</td>
						<td class="last alignc">${connhour.ha07}</td>
					</tr>
					<tr>
						<td class="first alignc">08:00 ~ 09:00</td>
						<td class="alignc">${connhour.h08}</td>
						<td class="last alignc">${connhour.ha08}</td>
					</tr>
					<tr>
						<td class="first alignc">09:00 ~ 10:00</td>
						<td class="alignc">${connhour.h09}</td>
						<td class="last alignc">${connhour.ha09}</td>
					</tr>
					<tr>
						<td class="first alignc">10:00 ~ 11:00</td>
						<td class="alignc">${connhour.h10}</td>
						<td class="last alignc">${connhour.ha10}</td>
					</tr>
					<tr>
						<td class="first alignc">11:00 ~ 12:00</td>
						<td class="alignc">${connhour.h11}</td>
						<td class="last alignc">${connhour.ha11}</td>
					</tr>
					<tr>
						<td class="first alignc">12:00 ~ 13:00</td>
						<td class="alignc">${connhour.h12}</td>
						<td class="last alignc">${connhour.ha12}</td>
					</tr>
					<tr>
						<td class="first alignc">13:00 ~ 14:00</td>
						<td class="alignc">${connhour.h13}</td>
						<td class="last alignc">${connhour.ha13}</td>
					</tr>
					<tr>
						<td class="first alignc">14:00 ~ 15:00</td>
						<td class="alignc">${connhour.h14}</td>
						<td class="last alignc">${connhour.ha14}</td>
					</tr>
					<tr>
						<td class="first alignc">15:00 ~ 16:00</td>
						<td class="alignc">${connhour.h15}</td>
						<td class="last alignc">${connhour.ha15}</td>
					</tr>
					<tr>
						<td class="first alignc">16:00 ~ 17:00</td>
						<td class="alignc">${connhour.h16}</td>
						<td class="last alignc">${connhour.ha16}</td>
					</tr>
					<tr>
						<td class="first alignc">17:00 ~ 18:00</td>
						<td class="alignc">${connhour.h17}</td>
						<td class="last alignc">${connhour.ha17}</td>
					</tr>
					<tr>
						<td class="first alignc">18:00 ~ 19:00</td>
						<td class="alignc">${connhour.h18}</td>
						<td class="last alignc">${connhour.ha18}</td>
					</tr>
					<tr>
						<td class="first alignc">19:00 ~ 20:00</td>
						<td class="alignc">${connhour.h19}</td>
						<td class="last alignc">${connhour.ha19}</td>
					</tr>
					<tr>
						<td class="first alignc">20:00 ~ 21:00</td>
						<td class="alignc">${connhour.h20}</td>
						<td class="last alignc">${connhour.ha20}</td>
					</tr>
					<tr>
						<td class="first alignc">21:00 ~ 22:00</td>
						<td class="alignc">${connhour.h21}</td>
						<td class="last alignc">${connhour.ha21}</td>
					</tr>
					<tr>
						<td class="first alignc">22:00 ~ 23:00</td>
						<td class="alignc">${connhour.h22}</td>
						<td class="last alignc">${connhour.ha22}</td>
					</tr>
					<tr>
						<td class="first alignc">23:00 ~ 24:00</td>
						<td class="alignc">${connhour.h23}</td>
						<td class="last alignc">${connhour.ha23}</td>
					</tr>
					<tr>
						<td class="first alignc">합계</td>
						<td class="alignc">${connhour.h_tot}</td>
						<td class="last alignc">100%</td>
					</tr>					
				</tbody>
			</table>
		</div>
		<!--// table 1dan list -->
		