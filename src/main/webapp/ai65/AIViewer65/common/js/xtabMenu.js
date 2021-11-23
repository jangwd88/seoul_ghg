    var selBinder, selRowIdx, selColIdx; // rightClick된 대상이 설정됨
    
    var shiftColSelected = false; // 열이동할 column을 선택했는지 여부
    var shiftColIdx = -1;         // 열이동으로 선택한 column의 (시작)인덱스
    var shiftColCount = 0;        // 열이동으로 선택한 column의 갯수
    

    function handleFreezing(command) {
        if (command == "freeze") {
            selBinder.freezeFrameAt(selRowIdx, selColIdx);
        } else if (command == "unFreeze") {
            selBinder.freezeFrameAt(0, 0);
        }
    }

    var replPattern = /,/g; // 차트데이타 replace(,)
    function handleChart() {
        var sheet = selBinder.sheet;
        var range = sheet.getSelections()[0];
        // 선택시작셀 인덱스:row,col  끝셀인덱스:row+rowCount-1,col+colCount-1
        if (range.row < selBinder.frozenRows || range.col < selBinder.frozenCols) {
            returnAndAlert("헤더를 제외한 순수 데이타영역만 선택하세요!");
            return;
        }
        if (range.rowCount == 1 && range.colCount == 1) {
            returnAndAlert("두개 이상의 데이타셀을 선택하세요!");
            return;
        }

        var data = new Array(range.rowCount); // all string type
        for (var i = 0; i < data.length; i++) {
            data[i] = new Array(range.colCount);
            for (var j = 0; j < range.colCount; j++) {
                // 링크(case)때문에 value대신 text사용
                // 데이타: null, undefined(pie에서는 오류), "숫자"는 허용됨
                //        "숫자"에서 ','는 허용되지 않음 -> 일괄삭제
                var t = sheet.getText(range.row+i, range.col+j);
                if (t && t.indexOf(",", 0) != -1) {
                    t = t.replace(replPattern, ""); // comma 제거
                }
                data[i][j] = t;
            }
        }

        // 헤더값획득: 기본틀고정셀이 데이타영역의 시작이므로 그 이전이 최종헤더셀임
        //           값헤더가 있는 경우 그 위치한 행 또는 열은 -- 함
        // null/undefined: 오류없이 텍스트로 출력됨(현재 그러한 데이타는 없음)
        var rowHeaderColumn = selBinder.frozenCols - 1;
        if (selBinder.valueHDPos == 0) rowHeaderColumn--; // row에 있음
        var colHeaderRow = selBinder.frozenRows - 1;
        if (selBinder.valueHDPos == 1) colHeaderRow--;    // col에 있음

        var rowHeaders = new Array(range.rowCount);
        for (i = 0; i < rowHeaders.length; i++) {
            rowHeaders[i] = sheet.getValue(range.row+i, rowHeaderColumn);
        }

        var colHeaders = new Array(range.colCount);
        for (i = 0; i < colHeaders.length; i++) {
            colHeaders[i] = sheet.getValue(colHeaderRow, range.col+i);
        }

        drawChart(data, rowHeaders, colHeaders, selBinder);
    }

    function handlePrint() {
        //PDFPrint();
        window.setTimeout(function() {
            window.alert("인쇄준비에 일정시간이 소요됩니다.\n인쇄창이 나타날 때까지 기다려 주세요.");
            aiXtabLoader.getBinder(0).spread.print(0);
        }, 300);
    }

    var colHeaderContextOptions = {
        callback: function(key, options) {
            if (key == "setShiftCol") {
                setShiftColumn(selBinder);
            } else if (key == "shiftCol") {
                handleColumnShift(selBinder);
            } else if (key == "hide") {
                selBinder.hide(selColIdx, true);
            } else if (key == "show") {
                selBinder.showHiddens(true);
            } else if (key == "showPartial") {
                selBinder.showHiddensPartial(true);
            }
        },
        items: {
            "setShiftCol": {
                name: "이동할 열로 선택",
                disabled: function() {
                    // 정적(조건)체크: 행필터링이나 열병합이 있는 경우 해당 인덱스를 초기화후 사용하므로
                    //                 열이동시 해당 인덱스도 동기화하는 경우에만 지원가능 (데이타포함)
                    //if (selBinder.filterOpt != null || selBinder.spannedCols.length > 0) return true;
                    // 행필터링: 열헤더내의 col( < frozenCols)에만 설정되므로 이동의 대상이 아님
                    //           (처리 함수에서 체크하여 이동을 거부함) -> 행필터링이 있어도 지원 가능

                    // 열병합(spannedCols)된 cols를, 이동시 동기화하는 경우에만 지원가능
                    //if (selBinder.spannedCols.length > 0) return true;
                    // :: 열병합제한: 열블럭 단위 이동개념을 도입하면서 사용중지
                    
                    // 감춰진 열 인덱스도 동기화하는 경우에만 지원가능
                    if (selBinder.hiddenCols.length > 0) return true;  // 동적(조건) 체크
                                
                    return false;
                }
            },
            "shiftCol": {
                name: "선택한 열을 여기로 이동",
                disabled: function() {
                    if (!window.shiftColSelected) return true;
                    // 열이동선택 후 감추기도 가능하므로 이동전 다시 체크해야 함
                    if (selBinder.hiddenCols.length > 0) return true;
                    
                    return false;
                }
            },
            "sep1": "------",
            "hide": {name: "현재열 숨기기"},
            "showPartial": {name: "영역내 숨김열 보이기"},
            "show": {name: "모든 숨김열 보이기"}
        },
        autoHide: true
    };

    var rowHeaderContextOptions = {
        callback: function(key, options) {
            if (key == "hide") {
                selBinder.hide(selRowIdx, false);
            } else if (key == "show") {
                selBinder.showHiddens(false);
            } else if (key == "showPartial") {
                selBinder.showHiddensPartial(false);
            }
        },
        items: {
            "hide":  {name: "현재행 숨기기"},
            "showPartial": {name: "영역내 숨김행 보이기"},
            "show": {name: "모든 숨김행 보이기"}
        },
        autoHide: true
    };

    var cellContextOptions = {
        callback: function(key, options) {
            if (key == "freeze") {
                handleFreezing(key);
            } else {
                if (key == "unFreeze") {
                    handleFreezing(key);
                } else if (key == "rowHdView") {
                    rowHdViewClicked(selBinder);
                } else if (key == "colHdView") {
                    colHdViewClicked(selBinder);
                } else if (key.indexOf("zoom", 0) == 0) {
                    zoomClicked(null, selBinder, key);
                } else if (key == "pasteExcel") {
                    aiXtabLoader.copyToClipboard(selBinder);
                } else if (key == "saveCSV") {
                    //aiXtabLoader.saveToCSV(selBinder);
                    ExcelConvert();
                } else if (key == "chart") {
                    handleChart();
                } else if (key == "print") {
                    //PDFPrint();
                    handlePrint();
                }
            }
        },
        items: {
            "freeze":  {name: "현재셀에 틀고정"},
            "unFreeze":  {name: "틀고정 취소"},
            "sep1": "------",
            "rowHdView":  {name: ""},
            "colHdView":  {name: ""},
            "sep2": "------",
            "zoomP":  {name: "확대(+10%)"},
            "zoomM":  {name: "축소(-10%)"},
            "zoom":  {name: "원래 크기로"},
            "sep3": "------",
            "saveCSV":  {name: "엑셀화일로 저장"},
            "pasteExcel": {name: "엑셀로 붙여넣기"},
            "sep4": "------",
            "chart":  {name: "차트 그리기", disabled: function(){return (window.ie78);}},
            "sep5": "------",
            "print":  {name: "인쇄"}
        },
        autoHide: true
    };

    function addXTabContextMenu(containerID) {
        $.contextMenu({
            selector: "#" + containerID,
            className: containerID + "-context-menu",
            build: function($trigger, e) { // 우클릭시마다 동적으로 호출됨
                //$trigger: element jq obj, e: original contextmenu event
                var offset = $trigger.offset();
                var x = e.pageX - offset.left;
                var y = e.pageY - offset.top;

                selBinder = aiXtabLoader.getBinderFromID(containerID);
                var target = selBinder.sheet.hitTest(x, y);
                if (!target) return false; // not display

                if (!window.ie78) {
                    selRowIdx = target.row;
                    selColIdx = target.col;
                }
                // IE8의 경우 위의 hitTest에서 해당 row/col을 일관성있게 얻지 못함(사용불가)
                // 따라서 셀클릭시 해당인덱스를 selRowIdx/selColIdx에 선행설정함
                // (클릭셀과 우클릭셀이 다른 경우 의도치않게 클릭셀이 사용될 수도 있음)
                // (아래는 최초에 바로 우클릭이 선행하는 경우로 지원이 곤란함)
                if (selRowIdx === undefined  || selColIdx === undefined) return false;

                if (target.rowViewportIndex == -1) { // column header
                    if (target.colViewportIndex == -1) return false; // 헤더머리
                    return colHeaderContextOptions;
                } else if (target.colViewportIndex == -1) { // row header
                    return rowHeaderContextOptions;
                } else { //  data cell
                    var rowHeaderVisible = selBinder.sheet.options.rowHeaderVisible;
                    var colHeaderVisible = selBinder.sheet.options.colHeaderVisible;
                    cellContextOptions.items.rowHdView.name = (rowHeaderVisible)? "행헤더 숨기기" : "행헤더 보이기";
                    cellContextOptions.items.colHdView.name = (colHeaderVisible)? "열헤더 숨기기" : "열헤더 보이기";

                    return cellContextOptions;
                }
            }
        });
    }

// 이하는 메뉴바의 사용자액션처리
    function zoomClicked(mode, binder, command) { // context메뉴와 사용자클릭을 모두 처리
        var zoomed; // binder에서 실제로 줌처리여부(else alert)
        var sizeEle = document.getElementById("vSize");
        if (binder) { // context메뉴
            zoomed = binder.zoom(command);
        } else { // // (현재는)메뉴바에서 사용자가 클릭한 경우
            var rate = parseInt(sizeEle.value, 10);
            if (mode == 0) { // 배율선택
            } else if (mode == 1) { // 축소
                rate -= 10;
            } else if (mode == 2) { // 확대
                rate += 10;
            }

            binder = aiXtabLoader.getBinder(0); // 하나만 가정 (id사용전환가능)
            zoomed = binder.zoom(null, rate);
        }

        if (zoomed && sizeEle) { // select element의 크기화 동기화
            var zf = binder.zoomFactor + ""; // string으로 전환
            var opts = sizeEle.options;
            for (var i = 0; i < opts.length; i++) {
                if (opts[i].value === zf) {
                    opts[i].selected = true;
                    break;
                }
            }
        }
    }

    function syncHDViewImage(config) {
        if (document.getElementById('menubar') == null) {
            return; // 메뉴바생략 -> 아래코드 진입불가
        }

        var hdVisible = true;
        if (config.hasOwnProperty("rowHeaderVisible")) {
            hdVisible = config["rowHeaderVisible"];
        }
        if (!hdVisible) { // 숨기기 이미지가 기본 로딩됨 -> 보이기 이미지로 전환
            document.getElementById('rowHD').src = window.installPath + "common/images/KO/rowHdShow.png";
        }

        hdVisible = true;
        if (config.hasOwnProperty("columnHeaderVisible")) {
            hdVisible = config["columnHeaderVisible"];
        }
        if (!hdVisible) {
            document.getElementById('colHD').src = window.installPath + "common/images/KO/colHdShow.png";
        }
    }

    function rowHdViewClicked(binder) { // context메뉴와 사용자클릭을 모두 처리
        if (!binder) { // (현재는)메뉴바에서 사용자가 클릭한 경우
            binder = aiXtabLoader.getBinder(0); // 하나만 가정 (id사용전환가능)
        }
        var visible = binder.sheet.options.rowHeaderVisible;
        var imgEle = document.getElementById('rowHD');
        if (imgEle) {
            var img = (visible)? "rowHdShow.png" : "rowHdHide.png";
            imgEle.src = window.installPath + "common/images/KO/" + img;
        }
        binder.sheet.options.rowHeaderVisible = !visible;
    }

    function colHdViewClicked(binder) {
        if (!binder) { // (현재는)메뉴바에서 사용자가 클릭한 경우
            binder = aiXtabLoader.getBinder(0); // 하나만 가정 (id사용전환가능)
        }
        var visible = binder.sheet.options.colHeaderVisible;
        var imgEle = document.getElementById('colHD');
        if (imgEle) {
            var img = (visible)? "colHdShow.png" : "colHdHide.png";
            imgEle.src = window.installPath + "common/images/KO/" + img;
        }
        binder.sheet.options.colHeaderVisible = !visible;
    }
    
    function setShiftColumn(binder) {
        if (window.selColIdx == undefined) { // 최초의 우클릭에서 인덱스미설정: 발생않을 것임
            window.shiftColSelected = false;
            return;
        }
        
        var selections = binder.sheet.getSelections(); // object array
        if (!selections || selections.length != 1) return; // 다중선택도 무효화

        //window.selColIdx: Selection이벤트와는 무관하게 우클릭(context메뉴)진입시 설정한 인덱스
        //                  아래에서 Selection이벤트가 발생한 영역(인덱스)과는 독립된 값임
        var selectedColIdx; // 이동(시작)열 인덱스
        // 직전의 선택이 열헤더인 상태에서 우클릭한 경우 (선택열에서 또는 이동하여)
        if (selections[0].row == -1) { // 단일열 또는 열 block
            var stIdx = selections[0].col; // -> 선택순서와 무관하게 가장 왼쪽(작은) 인덱스임
            var cols = selections[0].colCount; // 선택열 갯수
            if (cols > 1) { // 열 block
                // window.selColIdx가 (stIdx + cols - 1)에 속하는 경우에만
                // 선택영역내에서 우클릭한 경우임 -> 유효한 이동 액션으로 처리
                if (window.selColIdx < stIdx || window.selColIdx >= (stIdx+cols)) {
                    returnAndAlert("선택한 영역에서 메뉴를 실행하세요.");
                    return;
                }
                
                selectedColIdx = stIdx; // 영역내의 어느 col에서 진입하던 시작점을 인덱스로 설정
                window.shiftColCount = cols;
            } else { // 단일 열
                if (window.selColIdx != stIdx) {
                    returnAndAlert("선택한 열에서 메뉴를 실행하세요.");
                    return;
                }
                
                selectedColIdx = window.selColIdx;
                window.shiftColCount = 1;
            }
        } else { // 직전의 선택이 열헤더가 아닌 상태에서 우클릭한 경우 (단일 열)
            selectedColIdx = window.selColIdx; // 우클릭한 col을 인덱스로 설정
            window.shiftColCount = 1;
        }

        if (selectedColIdx < binder.frozenCols) {
            returnAndAlert("헤더열은 이동할 수 없습니다.");
            return;
        }
        // 열단위로 체크대신 전체에서 병합이 있는 경우 메뉴진입 금지로 변경
        /*if (binder.isSpannedColumn(selectedColIdx) ||
            binder.isSpannedColumn(selectedColIdx-1)) {
            // source와 직전 col에 열병합이 있는 경우 이동후, 앞뒤에 병합 유발
            returnAndAlert("병합된 셀이 포함되어 이동할 수 없는 열입니다.");
            return;
        }*/
        
        // 수정: 열block개념 지원으로 초기화된 열병합정보를 사용하지 않음(동기화어려움->진입허용)
        //       -> 이동후 side-effect병합을 유발하는 (선택된 block의 전후에 대한)병합을 체크
        
        // 선택(시작)이전 col area(열헤더에 해당하는 모든 rows를 포함)
        var testArea = new GC.Spread.Sheets.Range(0, selectedColIdx-1, binder.frozenRows, 1);
        if (hasColumnSpan(testArea, selectedColIdx, binder)) {
            // source 이전 col의 열병합이 source까지 이어지는 경우 이동후, 앞뒤에 병합 유발
            returnAndAlert("병합된 셀의 일부분만 포함하는 경우 이동할 수 없습니다.");
            return;
        }
    
        // 선택의 마지막 col area(열헤더에 해당하는 모든 rows를 포함)
        var lastCol = selectedColIdx + window.shiftColCount - 1;
        testArea = new GC.Spread.Sheets.Range(0, lastCol, binder.frozenRows, 1);
        if (hasColumnSpan(testArea, lastCol+1, binder)) { // 선택영역다음으로 span이 이어지는지 체크
            // source(블럭)에서 span이 종결되지 않고 다음으로 이어지는 경우 이동후, 앞뒤에 병합 유발
            returnAndAlert("병합된 셀의 일부분만 포함하는 경우 이동할 수 없습니다.");
            return;
        }
        
        // 선택영역의 0행(대개 열헤더)에 colSpan이 최대 한개만 존재해야 함 (논리데이타 블럭)
        // (1개 존재시 그 영역 즉 colSpan만큼을 자동으로 선택영역으로 재설정가능)
        // -> 굳이 2개블럭의 이동을 제한할 당위성도 없고 자동선택의 효용성도 의문 -> 구현보류
    
        window.shiftColIdx = selectedColIdx;
        window.shiftColSelected = true;
    }
    
    function handleColumnShift(binder) {
        if (!window.shiftColSelected) return;
        if (window.selColIdx >= window.shiftColIdx &&
            window.selColIdx < (window.shiftColIdx+window.shiftColCount)) {
            returnAndAlert("동일 위치로 이동할 수 없습니다.");
            return; //   target이 source영역내인 경우
        }
        if (window.selColIdx < binder.frozenCols) {
            returnAndAlert("헤더열로 이동할 수 없습니다.");
            return;
        }
        // 열단위로 체크대신 전체에서 병합이 있는 경우 메뉴진입 금지로 변경
        /*if (binder.isSpannedColumn(window.selColIdx-1)) {
            // target직전 col에 열병합이 있는 경우 이동후 병합 유발
            returnAndAlert("병합된 셀이 있어 이동할 수 없는 위치입니다.");
            return;
        }*/
        // 이동할 열(target) 이전 col area(열헤더에 해당하는 모든 rows를 포함)
        var testArea = new GC.Spread.Sheets.Range(0, window.selColIdx-1, binder.frozenRows, 1);
        if (hasColumnSpan(testArea, window.selColIdx, binder)) {
            // target직전 col에 target으로 이어지는 열병합이 있는 경우 이동후 병합 유발
            returnAndAlert("병합이 완료되지 않은 위치로 이동할 수 없습니다.");
            return;
        }


        var sourceCol = window.shiftColIdx;
        var targetCol = window.selColIdx;

        //binder.sheet.options.isProtected = false; // 불필요
        binder.sheet.getParent().suspendPaint();

        // 우->좌 이동시 sourceCol앞쪽에 빈 col이 생성되고 복사됨 -> sourceCol값이 shift되어야함
        if (sourceCol > targetCol) sourceCol += window.shiftColCount;
        
        binder.sheet.addColumns(targetCol, window.shiftColCount);
        for (var i = 0; i < window.shiftColCount; i++) {
            binder.sheet.setColumnWidth(targetCol+i, binder.sheet.getColumnWidth(sourceCol+i));
        }
        binder.sheet.copyTo(0, sourceCol, 0, targetCol,
                            binder.sheet.getRowCount(),
                            window.shiftColCount,
                            GC.Spread.Sheets.CopyToOptions.all);
        binder.sheet.deleteColumns(sourceCol, window.shiftColCount);

        // 이동한 열을 선택(시각적 효과)
        if (sourceCol < targetCol) targetCol -= window.shiftColCount;  // 좌->우 이동시
        binder.sheet.setSelection(0, targetCol, binder.sheet.getRowCount(), window.shiftColCount);

        binder.sheet.getParent().resumePaint();
        //binder.sheet.options.isProtected = true;
            
        window.shiftColSelected = false;
    }
    
    // 앞의 column area(testRange)에서 기준열(baseColIdx)까지 이어지는 열병합이 있는지를 test
    // baseColIdx: testRange의 마지막 col의 next 인덱스
    function hasColumnSpan(testRange, baseColIdx, binder) {
        // spans: 해당 area에서 addSpan을 통해 수행된(시작 or 이어지는) 모든 span을 return
        //        Range멤버값은, addSpan에 사용된 값으로 행/열 인덱스와 rowSpan/colSpan을 나타냄
        var spans = binder.sheet.getSpans(testRange); // Array of Range(maybe empty)
        if (spans && spans.length > 0) {
            for (var i = 0; i < spans.length; i++) {
                // (colIdx + colSpan) > baseColIdx : 직전col에서 시작되거나 이어지는 span이 계속됨
                //                                   span여부(colCount > 1)를 굳이 체크할 필요는 없음
                if ((spans[i].col + spans[i].colCount) > baseColIdx) {
                    // 이전 col의 열병합이 기준열까지 이어지는 경우 이동후, 앞뒤에 병합 유발
                    return true;
                }
            }
        }
        
        return false;
    }
    
