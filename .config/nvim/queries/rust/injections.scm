; Inject into sqlx::query!(r#"..."#, ...) as sql

(macro_invocation
 (scoped_identifier
    path: (identifier) @_path (#eq? @_path "sqlx")
    name: (identifier) @_name (#eq? @_name "query"))

 (token_tree
   (raw_string_literal
     (string_content) @injections.content))
 (#set! injection.language "sql")
 (#set! injection.include-children true))
