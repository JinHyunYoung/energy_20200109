
String.prototype.replaceAll = function(searchStr, replaceStr) {
	return eval('this.replace(/' + searchStr + '/g, replaceStr)');
}


var Util = {


	replace : function(str, original, replacement) {
		var result = '';
		if (str == undefined || str == null) {
			return result;
		}
		while(str.indexOf(original) != -1) {
			if (str.indexOf(original) > 0) {
				result = result + str.substring(0, str.indexOf(original)) + replacement;
			} else {
				result = result + replacement;
				str = str.substring(str.indexof(original) + original.length);
			}
		}

		return result + str;

	},

	/**
	 * 그리드 데이터를 폼으로 카피
	 *
	 * @param grid 대상 그리드 객체
	 * @param append 데이타 태그(hidden)를 생성할 상위 태그 객체
	 * @param prefix 생성될 태그명의 prefix
	 * @param searchStr 원래 그리드 칼럼명에서 치환될 문자열
	 * @param replaceStr 치환할 문자열
	 */
	copyGridToForm : function(grid, append, prefix, searchStr, replaceStr) {
		append.children().remove();

		var colModel = grid.getGridParam('colModel');
		var keys = grid.getDataIDs();

		var inputIndex = 0;
		var colName;

		$.each(keys, function (i, seq) {
			$.each(colModel, function(index, col) {

				var colValue = grid.getCell(key[i], col.name);
				if (col.name != 'cb') {
					if (searchStr != null && searchStr != '') {
						colName = Util.replace(col.name, searchStr, (replaceStr == null ? '' : replaceStr));
					} else {
						colName = col.Name;
					}
					$('<input type="hidden" />').attr('name', prefix + '[' + inputIndex + '].' + colName)
												.attr('value', cellvalue).appendTo(append);
				}
			});

		});
	},

	copyGridSelectedRowsToForm : function(grid, append, prefix, searchStr, replaceStr) {

		append.children().remove();

		var colModel = grid.getGridParam('colModel');
		var keys = grid.jqGrid('getGridParam', 'selarrrow');  // 선택된 rowid 배열

		var inputIndex = 0;
		var colName;

		$.each(keys, function (i, seq) {
			$.each(colModel, function(index, col) {

				var colValue = grid.getCell(key[i], col.name);
				if (col.name != 'cb') {
					if (searchStr != null && searchStr != '') {
						colName = Util.replace(col.name, searchStr, (replaceStr == null ? '' : replaceStr));
					} else {
						colName = col.Name;
					}
					$('<input type="hidden" />').attr('name', prefix + '[' + inputIndex + '].' + colName)
												.attr('value', cellvalue).appendTo(append);
				}
			});

		});
	},

	deleteGridRows : function (grid) {
		var seqs = grid.getGridParam('selarrrow');
		for (var i = seqs.length - 1; i >= 0; i--) {
			grid.jqGrid('delRowDatra', seqs[i]);
		}
	}


};