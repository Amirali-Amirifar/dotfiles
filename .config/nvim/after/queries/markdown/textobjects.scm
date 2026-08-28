;; extends
;;
;; @code_cell captures fenced code blocks so treesitter-textobjects
;; can treat them as text objects (`ib` / `ab`) and motions (`]b` / `[b`).
;; - @code_cell.inner : the code content between the fences
;; - @code_cell.outer : the whole block including ``` markers
;;
;; Wired up in lua/plugins/treesitter-textobjects.lua.

(fenced_code_block (code_fence_content) @code_cell.inner) @code_cell.outer
