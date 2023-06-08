function fn_overlapped() {
    var _id = $("#userID").val();
    
    $.ajax({
        type: "post",
        async: false,
        url: "./admin/overlapped.jsp",
        dataType: "json",
        data: {userID: _id},
        success: function(data, textStatus) {
            if (data.result == 'false') {
                alert("사용할 수 있는 ID입니다.");
                $('#checkIDdup').prop("disabled", true);
                $('#userID').prop("disabled", true);
                $('#userIDval').val(_id);
            } else {
                alert("사용할 수 없는 ID입니다.");
                falseCSS("userID");
            }
        },
        error: function(data, textStatus) {
            alert("오류가 발생했습니다.");
        },
        complete: function(data, textStatus) {
        }
    });
}