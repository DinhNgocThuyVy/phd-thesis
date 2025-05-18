-- Chapter summary box implementation
function Div(el)
  -- Check if this is a summary div
  if el.classes:includes("summary") then
    -- Get the content
    local content = pandoc.utils.stringify(el)
    
    if quarto.doc.isFormat("pdf") then
      -- LaTeX output for PDF
      return pandoc.RawBlock('latex', '\\begin{chaptersummary}\n' .. content .. '\n\\end{chaptersummary}')
    else
      -- HTML output
      return pandoc.Div({
        pandoc.RawBlock('html', '<div class="chapter-summary-title">Chapter Summary</div>'),
        table.unpack(el.content)  -- Keep the original content structure
      }, {class = "chapter-summary"})
    end
  end
  
  return el
end

-- Keep the shortcode implementation too (for alternative usage)
function ChapterSummary(args, kwargs, content)
  -- Get the content for the summary box
  local summary_text = pandoc.utils.stringify(content)
  
  -- Different implementations for different formats
  if quarto.doc.isFormat("pdf") then
    -- LaTeX output for PDF
    return pandoc.RawBlock('latex', '\\begin{chaptersummary}\n' .. summary_text .. '\n\\end{chaptersummary}')
  else
    -- HTML output
    return pandoc.Div({
      pandoc.RawBlock('html', '<div class="chapter-summary-title">Chapter Summary</div>'),
      pandoc.Para(content)
    }, {class = "chapter-summary"})
  end
end

-- Return both filter and shortcode
return {
  {'Div', Div},
  ['summary'] = ChapterSummary
}
