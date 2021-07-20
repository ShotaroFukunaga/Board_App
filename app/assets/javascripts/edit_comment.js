$(function() {
    $(document).on("click", '.js-edit-comment-button', function(e) {
        e.preventDefault(); //ボタンのデフォルト機能の送信処理を防いでいる
        const commentId = $(this).data("comment-id")
        switchToEdit(commentId)
    })

    $(document).on("click", '.js-button-edit-comment-cancel', function() {
        clearErrorMessages()
        const commentId = $(this).data("comment-id")//data-comment-id="<%= comment.id %>"
        //thisはこの場合functionに入っているjs-button-edit-comment-cancelを参照にしている
        switchToLabel(commentId)
        //上記で代入したcommentIDを関数switchToLabelに渡している
    })

    $(document).on("click", '.js-button-comment-update', function() {
        clearErrorMessages()
        const commentId = $(this).data("comment-id")
        submitComment($("#js-textarea-comment-" + commentId).val(), commentId)
            //このthen.catchと言うのはsubmitCommentのPromiseが成功したかどうかで処理が分岐する
            .then(result => { //functionの値を参照した、resultをアロー関数にして下記の処理を記述
                $("#js-comment-" + result.comment.id).html(result.comment.body.replace(/\r?\n/g, '<br>'))
                switchToLabel(result.comment.id)
            })
            .catch(result => {//コントローラーから帰ってくる値はjson形式
                const commentId = result.responseJSON.comment.id
                const messages = result.responseJSON.errors.messages
                showErrorMessages(commentId, messages)
            })
    })

    function switchToLabel(commentId) {
        $("#js-textarea-comment-box-" + commentId).hide()//表示されている要素を非表示にする。
        $("#js-comment-" + commentId).show()//非表示になっている要素を表示する。
    }

    function switchToEdit(commentId) {
        $("#js-comment-" + commentId).hide()
        $("#js-textarea-comment-box-" + commentId).show()
    }

    function showErrorMessages(commentId, messages) {//エラーが発生したらエラーメッセージを差し込む関数
        $('<p class="error_messages text-danger">' + messages.join('<br>') + '</p>').insertBefore($("#js-textarea-comment-" + commentId))
    }

    function submitComment(body, commentId) {
        return new Promise(function(resolve, reject) {
            $.ajax({//jQueryでajaxでリクエストを送る時の処理
                type: 'PATCH',
                url: '/comments/' + commentId,
                data: {
                    comment: {
                        body: body
                    }
                }
            //commentコントローラーにデータを送信、帰ってきたstatusの値(okまたはbad)によって処理が分けられる。
            }).done(function (result) {//後に実行したい処理のメソッド
                resolve(result)//処理が成功した時にメッセージを表示する関数
            }).fail(function (result) {//エラーが発生した時のメソッド
                reject(result)//処理が失敗した時にメッセージを表示する関数
            });
        })
    }

    function clearErrorMessages() {//更新した時にメッセージが消える関数
        $("p.error_messages").remove()
    }
});