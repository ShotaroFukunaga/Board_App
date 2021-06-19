module ApplicationHelper
    def page_title(page_titile = '')
        base_title = 'RUNTEQ BOARD APP'

        page_titile.empty? ? base_title : page_titile + "|" + base_title
    end
end
