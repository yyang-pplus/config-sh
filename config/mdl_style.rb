all

# Ignore line length in code blocks.
rule 'MD013', code_blocks: false
exclude_rule 'MD013'

# I prefer two blank lines before each heading.
exclude_rule 'MD012' # Multiple consecutive blank lines

# I find it necessary to use '<br/>' to force line breaks.
exclude_rule 'MD033' # Inline HTML

# If a page is printed, it helps if the URL is viewable.
exclude_rule 'MD034' # Bare URL used

# To work with frontmatter
exclude_rule 'MD041' # No first line h1
