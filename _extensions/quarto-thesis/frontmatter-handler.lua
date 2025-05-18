-- This helper script processes frontmatter text files for HTML rendering

function readTextFile(filepath)
  local file = io.open(filepath, "r")
  if file then
    local content = file:read("*all")
    file:close()
    return content
  else
    return "File not found: " .. filepath
  end
end

function Meta(meta)
  if quarto.doc.isFormat("html") and meta.thesis then
    -- Process abstract files
    if meta.thesis.abstract then
      if meta.thesis.abstract.english then
        local path = pandoc.utils.stringify(meta.thesis.abstract.english)
        if not meta.thesis.abstract.english.text and path:match("%.tex$") then
          local content = readTextFile(path)
          meta.thesis.abstract.english = content
        end
      end
      
      if meta.thesis.abstract.french then
        local path = pandoc.utils.stringify(meta.thesis.abstract.french)
        if not meta.thesis.abstract.french.text and path:match("%.tex$") then
          local content = readTextFile(path)
          meta.thesis.abstract.french = content
        end
      end
    end
    
    -- Process acknowledgements
    if meta.thesis.acknowledgements then
      local path = pandoc.utils.stringify(meta.thesis.acknowledgements)
      if path:match("%.tex$") then
        local content = readTextFile(path)
        meta.thesis.acknowledgements = content
      end
    end
    
    -- Process dedication
    if meta.thesis.dedication then
      local path = pandoc.utils.stringify(meta.thesis.dedication)
      if path:match("%.tex$") then
        local content = readTextFile(path)
        meta.thesis.dedication = content
      end
    end
    
    -- Process abbreviations
    if meta.thesis.abbreviations then
      local path = pandoc.utils.stringify(meta.thesis.abbreviations)
      if path:match("%.tex$") then
        local content = readTextFile(path)
        meta.thesis.abbreviations = content
      end
    end
    
    -- Process symbols
    if meta.thesis.symbols then
      local path = pandoc.utils.stringify(meta.thesis.symbols)
      if path:match("%.tex$") then
        local content = readTextFile(path)
        meta.thesis.symbols = content
      end
    end
  end
  
  return meta
end
