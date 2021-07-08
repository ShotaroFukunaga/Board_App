module ApplicationHelper
    def page_title(page_titile = '', admin = false)
        base_title = if admin
                        'RUNTEQ BOARD APP(管理画面)'
                    else
                        'RUNTEQ BOARD APP'
                    end

        page_titile.empty? ? base_title : page_titile + "|" + base_title
    end
end
