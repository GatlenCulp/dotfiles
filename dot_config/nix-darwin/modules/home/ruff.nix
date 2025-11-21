{
  line-length = 99;
  format = {
    quote-style = "double";
    indent-style = "space";
  };
  # Sort imports on fix
  select = [ "I" ];

  lint = {
    # logger-objects = [ "coco.config.logger" ];
    select = [ "ALL" ];
    ignore = [
      "S101" # Allow assert
      "E731" # Allow lambdas
      "EM101" # Allow strings in exceptions
      "T201" # Allow print
      "D103" # Allow public functions w/o docstrings
      "D105" # Allow undocumented magic methods
      "D107" # Same as above
      "D205" # Allow multi-line summary
      "D415" # Less strict docstrings
      "COM812" # Allow single-line string concat (Conflicts with ISC001)
      "ISC001" # Allow single-line string concat (Conflicts with COM812)
      "TD002" # Allow user-less TODOs
      "TD003" # Allow issue-less TODOs
      "UP007" # Allow non-use of pipe for types
      "UP035" # Same as above
      # EXTRA ANNOYING THINGS NEW
      "ERA001"
      "RET504"
      "FBT001"
      "FBT002"
      "INP001"
      "D100"
      "W293" # Extra white space
      "B018" # Useless expression
      "TRY003" # Long exception messages
    ];

    fixable = [
      "W293" # Can fix extra white space
    ];

    mccabe = { max-complexity = 10; };
    pycodestyle = { max-doc-length = 99; };
    pydocstyle = { convention = "google"; };

    isort = {
      # known-first-party = [ "coco" ];
      force-sort-within-sections = true;
    };

    per-file-ignores = {
      "**/__init__.py" = [
        "F401" # Allow unused imports in __init__.py
      ];
      "**/*.ipynb" = [
        "S101" # Allow assert
        "E731" # Allow lambdas
        "EM101" # Allow strings in exceptions
        "T201" # Allow print
        "D103" # Allow public functions w/o docstrings
        "D105" # Allow undocumented magic methods
        "D107" # Same as above
        "D205" # Allow multi-line summary
        "D415" # Less strict docstrings
        "TD002" # Allow user-less TODOs
        "TD003" # Allow issue-less TODOs
        "UP007" # Allow non-use of pipe for types
        "UP035" # Same as above
      ];
      "tests/**/*.py" = [
        "S101" # Allow assert
        "ARG001" # Allow unused function args for fixtures
        "FBT001" # Allow booleans as function params
        "PLR2004" # Allow magic values in comparisons
        "S311" # Allow pseudo-random generators
        "ANN001" # Allow for non-typed functions
        "ANN201" # Allow for non-typed functions
        "RET503" # Allow for implicit ignores
      ];
    };
  };
}
