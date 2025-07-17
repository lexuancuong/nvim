return {
    {
        "connorwyatt/nvim-ufo",
        branch = "close_fold_current_line",
        dependencies = {
            "kevinhwang91/promise-async",
        },
        opts = {
            close_fold_kinds_for_ft = {
                default = { "imports", "comment" },
            },
            close_fold_current_line = true,
            fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (" 󰛑  %d lines folded"):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, "Comment" })
                return newVirtText
            end,
            preview = {
                win_config = {
                    border = "none",
                    winhighlight = "NormalFloat:NormalFloat",
                    winblend = 0,
                },
            },
        },
    },
}
