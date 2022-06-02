call wilder#setup({
      \ 'modes': [':', '/', '?'],
      \ 'next_key': '<Tab>',
      \ 'previous_key': '<S-Tab>',
      \ })

call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline({
      \       'language': 'python',
      \       'fuzzy': 1,
      \     }),
      \     wilder#python_search_pipeline({
      \       'pattern': wilder#python_fuzzy_pattern(),
      \       'sorter': wilder#python_difflib_sorter(),
      \       'engine': 're',
      \     }),
      \   ),
      \ ])

call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':': wilder#popupmenu_renderer({
      \   'highlighter': wilder#basic_highlighter(),
      \   'highlights': {
        \     'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
        \   },
        \   'left': [
          \     ' ', wilder#popupmenu_devicons(),
          \   ],
          \   'right': [
            \     ' ', wilder#popupmenu_scrollbar(),
            \   ],
            \ }),
            \ '/': wilder#popupmenu_renderer({
            \   'highlighter': wilder#basic_highlighter(),
            \   'highlights': {
              \     'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
              \   },
              \   'right': [
                \     ' ', wilder#popupmenu_scrollbar(),
                \   ],
                \ }),
                \ '?': wilder#popupmenu_renderer({
                \   'highlighter': wilder#basic_highlighter(),
                \   'highlights': {
                  \     'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
                  \   },
                  \   'right': [
                    \     ' ', wilder#popupmenu_scrollbar(),
                    \   ],
                    \ }),
                    \ }))
