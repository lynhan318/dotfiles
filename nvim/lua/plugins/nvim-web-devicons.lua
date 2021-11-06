return function()
    require'nvim-web-devicons'.setup {
        override = {
            html = {icon = "", color = "#f76c7c", name = "html"},
            css = {icon = "", color = "#61afef", name = "css"},
            tcss = {icon = "", color = "#61afef", name = "css"},
            acss = {icon = "", color = "#61afef", name = "css"},
            xml = {icon = "", color = "#f76c7c", name = "xml"},
            txml = {icon = "", color = "#f76c7c", name = "txml"},
            axml = {icon = "", color = "#f76c7c", name = "axml"},
            map = {icon = "", color = "#566370", name = "txt"},
            txt = {icon = "", color = "#61afef", name = "text"},
            mp3 = {icon = "", color = "#566370", name = "mp3"},
            mp4 = {icon = "", color = "#5c6370", name = "mp4"},
            -- md = {
            --   icon = "",
            --   color = "#f3a96a",
            --   name = "md"
            -- }, 
            -- markdown = {
            --   icon = "",
            --   color = "#f3a96a",
            --   name = "markdown"
            -- }, 
            -- mdx = {
            --   icon = "",
            --   color = "#f3a96a",
            --   name = "mdx"
            -- }, 
            lock = {icon = "", color = "#5c6370", name = "lock"}
        }
    }
end
