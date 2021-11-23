var searchForm = $("#searchForm");
	$("#searchForm button").on("click",function(e) {
	    // 화면에서 키워드가 없다면 검색을 하지 않도록 제어
		if (!searchForm.find("option:selected").val()) {
			alert("검색 종류를 선택하세요");
			return false;
		}

		if (!searchForm.find("input[name='keyword']").val()) {
			alert("키워드를 입력하세요");
			return false;
		}

	    // 페이지 번호를 1로 처리
		searchForm.find("input[name='pno']").val("1");

	    // 폼 태그의 전송을 막음
		e.preventDefault();
		searchForm.submit();
	});