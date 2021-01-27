<%--
  Created by IntelliJ IDEA.
  User: Suze
  Date: 1/13/2021
  Time: 3:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript">

    $(function () {
        // 跳到指定的页码
        $("#searchPageBtn").click(function () {

            var pageNo = $("#pn_input").val();
            var pageTotal = ${requestScope.page.pageTotal};

            if (pageNo < 1 || pageNo > pageTotal) {
                alert("Oh no no!");
            } else {
                location.href = "${pageScope.basePath}${ requestScope.page.url }&pageNo=" + pageNo;
            }

            <%--var pageTotal = ${requestScope.page.pageTotal};--%>
            <%--alert(pageTotal);--%>

            // javaScript语言中提供了一个location地址栏对象
            // 它有一个属性叫href.它可以获取浏览器地址栏中的地址
            // href属性可读，可写

        });
    });

</script>

<div id="page_nav">
    <c:if test="${requestScope.page.pageNo>1}">

        <a href="${ requestScope.page.url }&pageNo=1">First</a>
        <a href="${ requestScope.page.url }&pageNo=${requestScope.page.pageNo-1}">Prev</a>
    </c:if>

    <%--页码输出的开始--%>
    <c:choose>
        <%--情况1：如果总页码小于等于5的情况，页码的范围是：1-总页码--%>
        <c:when test="${ requestScope.page.pageTotal <= 5 }">
            <c:set var="begin" value="1"/>
            <c:set var="end" value="${requestScope.page.pageTotal}"/>
        </c:when>
        <%--情况2：总页码大于5的情况--%>
        <c:when test="${requestScope.page.pageTotal > 5}">
            <c:choose>
                <%--小情况1：当前页码为前面3个：1，2，3的情况，页码范围是：1-5.--%>
                <c:when test="${requestScope.page.pageNo <= 3}">
                    <c:set var="begin" value="1"/>
                    <c:set var="end" value="5"/>
                </c:when>
                <%--小情况2：当前页码为最后3个，8，9，10，页码范围是：总页码减4 - 总页码--%>
                <c:when test="${requestScope.page.pageNo > requestScope.page.pageTotal-3}">
                    <c:set var="begin" value="${requestScope.page.pageTotal-4}"/>
                    <c:set var="end" value="${requestScope.page.pageTotal}"/>
                </c:when>
                <%--小情况3：4，5，6，7，页码范围是：当前页码减2 - 当前页码加2--%>
                <c:otherwise>
                    <c:set var="begin" value="${requestScope.page.pageNo-2}"/>
                    <c:set var="end" value="${requestScope.page.pageNo+2}"/>
                </c:otherwise>
            </c:choose>
        </c:when>
    </c:choose>

    <c:forEach begin="${begin}" end="${end}" var="i">
        <c:if test="${i == requestScope.page.pageNo}">
            【${i}】
        </c:if>
        <c:if test="${i != requestScope.page.pageNo}">
            <a href="${ requestScope.page.url }&pageNo=${i}">${i}</a>
        </c:if>
    </c:forEach>
    <%--页码输出的结束--%>

    <c:if test="${requestScope.page.pageNo < requestScope.page.pageTotal}">
        <a href="${ requestScope.page.url }&pageNo=${requestScope.page.pageNo+1}">Next</a>
        <a href="${ requestScope.page.url }&pageNo=${requestScope.page.pageTotal}">Last</a>
        <%--            Online_BookStore/&pageNo=6--%>
    </c:if>

    Pages-${requestScope.page.pageTotal}，Books-${requestScope.page.pageTotalCount}
    To <input value="${param.pageNo}" name="pn" id="pn_input"/> Page
    <input id="searchPageBtn" type="button" value="GO">
</div>

