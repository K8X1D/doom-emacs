(use-modules (guix packages)
	     (guix download)
	     (guix git-download)

	     (guix build-system haskell)
	     (guix build-system python)
	     (guix build-system julia)

	     (gnu packages haskell-xyz)
	     (gnu packages python-crypto)
	     (gnu packages python-build)
	     (gnu packages python-xyz)
	     (gnu packages sphinx)
	     (gnu packages check)
	     (gnu packages python-web)
	     (gnu packages xml)
	     (gnu packages julia-xyz)

	     ((guix licenses) #:prefix license:))


;; Julia
(define-public julia-cstparser
  (package
    (name "julia-cstparser")
    (version "3.3.4")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/julia-vscode/CSTParser.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "162jpcdph26ybg7rajbvfcbpnngygybpzk5bry4c4ppda3m1dl1i"))))
    (build-system julia-build-system)
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'fix-or-ignore-tests
            (lambda _
              (substitute* "test/iterate.jl"
                (("parser.jl")
                 (string-append #$output "/share/julia/loadpath/CSTParser/test/parser.jl"))
                (("../src")
                 (string-append #$output "/share/julia/loadpath/CSTParser/src")))
              (substitute* "test/check_base.jl"
                (("testset.*" all)
                 (string-append all "return\n"))))))))
    (inputs (list julia-tokenize))
    (home-page "https://github.com/julia-vscode/CSTParser.jl")
    (synopsis "Parser for Julia")
    (description "This package provides a parser for Julia code.")
    (license license:expat)))

(define-public julia-tokenize
  (package
    (name "julia-tokenize")
    (version "0.5.24")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaLang/Tokenize.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1l3dy6nad0viavzy26lfnhzpd3gcxgaq7yvm7h1ja280xsh60p3i"))))
    (build-system julia-build-system)
    (home-page "https://github.com/JuliaGPU/Tokenize.jl")
    (synopsis "Tokenize a string or buffer containing Julia code")
    (description "This package takes a string or buffer containing Julia code,
performs lexical analysis and returns a stream of tokens.")
    (license license:expat)))

(define-public julia-languageserver
  (package
   (name "julia-languageserver")
   (version "4.3.1")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url "https://github.com/julia-vscode/LanguageServer.jl")
	   (commit (string-append "v" version))))
     (file-name (git-file-name name version))
     (sha256
      (base32 "08f0lvw0fj4z45pm3wj11viv6glq0hccrliw1jcacj3rqk5p5jsl"))))
   (build-system julia-build-system)
   (inputs (list julia-json julia-cstparser))
   (home-page "https://github.com/julia-vscode/LanguageServer.jl")
   (synopsis "An implementation of the Microsoft Language Server Protocol for the Julia language.")
   (description "An implementation of the Microsoft Language Server Protocol for the Julia language.")
   (license license:expat)))

(define-public julia-symbolserver
  (package
   (name "julia-symbolserver")
   (version "7.2.1")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url "https://github.com/julia-vscode/SymbolServer.jl")
	   (commit (string-append "v" version))))
     (file-name (git-file-name name version))
     (sha256
      (base32 "0di754fzc42bj3c0clcql2s2a0xxf78k4l83zjk9amgh100xbs49"))))
   (build-system julia-build-system)
    (arguments
     (list #:tests? #f))        ; Tests try to read SSL certificates.
   (home-page "https://github.com/julia-vscode/SymbolServer.jl")
   (synopsis "Julia helper package for LSP")
   (description "SymbolServer is a helper package for LanguageServer.jl that provides information about internal and exported variables of packages (without loading them). A package's symbol information is initially loaded in an external process but then stored on disc for (quick loading) future use.")
   (license license:expat)))


;; Python

(define-public python-flaky
(package
  (name "python-flaky")
  (version "3.7.0")
  (source (origin
            (method url-fetch)
            (uri (pypi-uri "flaky" version))
            (sha256
             (base32
              "03daz352021211kvdb056f3afrd2gsdq0rd1awgr38910xw01l9s"))))
  (build-system python-build-system)
  (home-page "https://github.com/box/flaky")
  (synopsis "Plugin for nose or pytest that automatically reruns flaky tests.")
  (description
   "Plugin for nose or pytest that automatically reruns flaky tests.")
  (license #f))
)

(define-public python-mock 
(package
  (name "python-mock")
  (version "5.0.1")
  (source (origin
            (method url-fetch)
            (uri (pypi-uri "mock" version))
            (sha256
             (base32
              "0ssaad5a33qdqcrn8pph2ka5701jmmlllrr1zmvpkgxs0df51sp3"))))
  (build-system python-build-system)
  (native-inputs (list python-pytest python-pytest-cov))
  (home-page "http://mock.readthedocs.org/en/latest/")
  (synopsis "Rolling backport of unittest.mock for all Pythons")
  (description "Rolling backport of unittest.mock for all Pythons")
  (license #f))
)

(define-public python-parver
(package
  (name "python-parver")
  (version "0.4")
  (source (origin
            (method url-fetch)
            (uri (pypi-uri "parver" version))
            (sha256
             (base32
              "1jlvkbdrbb9y02fy84mr0jr6jhf4b145w1dsl3lkwdsk7jwxp8yl"))))
  (build-system python-build-system)
  (propagated-inputs (list python-arpeggio python-attrs
                           python-typing-extensions))
  (native-inputs (list python-doc8
                       python-flake8
                       python-hypothesis
                       python-pep8-naming
                       python-pretend
                       python-pytest))
  (home-page "")
  (synopsis "Parse and manipulate version numbers.")
  (description "Parse and manipulate version numbers.")
  (license license:expat))
)

(define-public python-pytest-timeout
(package
  (name "python-pytest-timeout")
  (version "2.1.0")
  (source (origin
            (method url-fetch)
            (uri (pypi-uri "pytest-timeout" version))
            (sha256
             (base32
              "1nf339zg6qam3681f72j9c8fbqk8qcilna92psmzh4n60isa0z60"))))
  (build-system python-build-system)
  (propagated-inputs (list python-pytest))
  (home-page "https://github.com/pytest-dev/pytest-timeout")
  (synopsis "pytest plugin to abort hanging tests")
  (description "pytest plugin to abort hanging tests")
  (license license:expat))
)

(define-public python-pytest-xdist 
(package
  (name "python-pytest-xdist")
  (version "3.2.1")
  (source (origin
            (method url-fetch)
            (uri (pypi-uri "pytest-xdist" version))
            (sha256
             (base32
              "09s7yn2l1n9fk63yv3raj5hk7gwhw1w79nvjwi4bjhmjv2cbsj8q"))))
  (build-system python-build-system)
  (propagated-inputs (list python-execnet python-pytest))
  (native-inputs (list python-filelock))
  (home-page "https://github.com/pytest-dev/pytest-xdist")
  (synopsis
   "pytest xdist plugin for distributed testing, most importantly across multiple CPUs")
  (description
   "pytest xdist plugin for distributed testing, most importantly across multiple
CPUs")
  (license license:expat))
)

(define-public python-virtualenv-clone
  (package
   (name "python-virtualenv-clone")
   (version "0.5.7")
   (source (origin
	    (method url-fetch)
	    (uri (pypi-uri "virtualenv-clone" version))
	    (sha256
	     (base32
	      "06jhhf8hndcgyk9k3bjbk3vz1xpajfxj9667agqzhlk1qcsyk3j1"))))
   (build-system python-build-system)
   (home-page "https://github.com/edwardgeorge/virtualenv-clone")
   (synopsis "script to clone virtualenvs.")
   (description "script to clone virtualenvs.")
   (license license:expat))
  )


(define-public python-pipenv
  (package
   (name "python-pipenv")
   (version "2023.3.20")
   (source (origin
	    (method url-fetch)
	    (uri (pypi-uri "pipenv" version))
	    (sha256
	     (base32
	      "1f7h742pgxjr0l51ahs6cs8jmy03dwmwcl5qlhzrc6fiscdvdfvp"))))
   (build-system python-build-system)
   (propagated-inputs (list python-certifi python-setuptools python-virtualenv
			    python-virtualenv-clone))
   (native-inputs (list python-beautifulsoup4
			python-black
			python-flake8
			python-flaky
			python-invoke
			python-mock
			python-parver
			python-pytest
			python-pytest-timeout
			python-pytest-xdist
			python-sphinx
			python-towncrier))
   (home-page "https://github.com/pypa/pipenv")
   (synopsis "Python Development Workflow for Humans.")
   (description "Python Development Workflow for Humans.")
   (license license:expat))
  )

(define-public python-pytest
(package
  (name "python-pytest")
  (version "7.3.0")
  (source (origin
            (method url-fetch)
            (uri (pypi-uri "pytest" version))
            (sha256
             (base32
              "0zg5isvbqj93jb6mp5cz1jh639sx6d4i5yzpzpml79hfpxzc5v2q"))))
  (build-system python-build-system)
  (propagated-inputs (list python-colorama
                           python-exceptiongroup
                           python-importlib-metadata
                           python-iniconfig
                           python-packaging
                           python-pluggy
                           python-tomli))
  (native-inputs (list python-argcomplete
                       python-attrs
                       python-hypothesis
                       python-mock
                       python-nose
                       python-pygments
                       python-requests
                       python-xmlschema))
  (home-page "https://docs.pytest.org/en/latest/")
  (synopsis "pytest: simple powerful testing with Python")
  (description "pytest: simple powerful testing with Python")
  (license license:expat))
)

(define-public python-pyenv
(package
  (name "python-pyenv")
  (version "0.0.1")
  (source (origin
            (method url-fetch)
            (uri (pypi-uri "pyenv" version))
            (sha256
             (base32
              "1nzy6hhiz2sd2hgfpdqb8b037k7pf4gmz52spjkaswk7na0zhaac"))))
  (build-system python-build-system)
  (home-page "https://github.com/pyenv/pyenv")
  (synopsis "pyenv project placeholder package")
  (description "pyenv project placeholder package")
  (license license:expat))
)

(define-public python-towncrier
(package
  (name "python-towncrier")
  (version "22.12.0")
  (source (origin
            (method url-fetch)
            (uri (pypi-uri "towncrier" version))
            (sha256
             (base32
              "0k83cisk139v28mjsa819b8qz733q45lr45f0bm9lsk4bzkxfjcw"))))
  (build-system python-build-system)
  (propagated-inputs (list python-click
                           python-click-default-group
                           python-incremental
                           python-jinja2
                           python-setuptools
                           python-tomli))
  (native-inputs (list python-furo python-packaging python-sphinx
                       python-twisted))
  (home-page "https://github.com/twisted/towncrier")
  (synopsis "Building newsfiles for your project.")
  (description "Building newsfiles for your project.")
  (license license:expat))
)



;; Haskell language server
(define-public ghc-hcg-minus
  (package
   (name "ghc-hcg-minus")
   (version "0.16")
   (source (origin
	    (method url-fetch)
	    (uri (hackage-uri "hcg-minus" version))
	    (sha256
             (base32
              "0578yi5zc61chmp936s5wczdd8j3593br24zx57sqr5a50c0mwmc"))))
   (build-system haskell-build-system)
   (inputs (list ghc-colour ghc-random))
   (home-page "http://rd.slavepianos.org/t/hcg-minus")
   (synopsis "haskell cg (minus)")
   (description "cg (minus) library")
   (license #f))
  )

(define-public ghc-hps
(package
  (name "ghc-hps")
  (version "0.16")
  (source (origin
            (method url-fetch)
            (uri (hackage-uri "hps" version))
            (sha256
             (base32
              "0y819776sk97hdwf67x67289gdqmxn2g39l7ri0n8z8vdap5rq96"))))
  (build-system haskell-build-system)
  (inputs (list ghc-hcg-minus))
  (home-page "http://rd.slavepianos.org/t/hps")
  (synopsis "Haskell Postscript")
  (description
   "Haskell library partially implementing the postscript drawing model.")
  (license #f))
)

(define-public ghc-hls
  (package
   (name "ghc-hls")
   (version "0.15")
   (source (origin
            (method url-fetch)
            (uri (hackage-uri "hls" version))
            (sha256
             (base32
              "0h32fyvnqkxx8c9vfpdjvnqaxkvr8b15myjavxmnm6kwh7v2796l"))))
   (build-system haskell-build-system)
   (inputs (list ghc-hcg-minus ghc-hps))
   (home-page "http://rd.slavepianos.org/t/hls")
   (synopsis "Haskell Lindenmayer Systems")
   (description "Haskell Lindenmayer Systems")
   (license #f))
  )


;; Manifest
(concatenate-manifests
 (list
  (specifications->manifest
   (list
    "emacs" ;; The extensible, customizable, self-documenting text editor
    "git" ;; Distributed version control system
    "ripgrep" ;; Line-oriented search tool
    "fd" ;; Simple, fast and user-friendly alternative to find

    ;; Fonts
    "font-fira-sans" ;; Humanist sans-serif with numerous weights emphasizing legibility
    "font-fira-code" ;; Monospaced font with programming ligatures

    ;; Email module
    "mu" ;; Quickly find emails
    "isync" ;; Mailbox synchronization program

    ;; Org support
    "graphviz" ;; Graph visualization software
    "ispell" ;; Interactive spell-checking tool for Unix

    ;; Vterm
    "cmake" ;; Cross-platform build system
    "libtool" ;; Generic shared library support tools
    "perl" ;; Implementation of the Perl programming language

    ;; Markdown
    "grip" ;; Preview Markdown files using the GitHub API

    ;; Nix
    "nixfmt" ;; Opinionated formatter for Nix

    ;; Haskell support
    "ghc-next" ;; The Glasgow Haskell Compiler
    "ghc-colour" ;; Model for human colour perception

    ;; Julia support
    "julia" ;; High-performance dynamic language for technical computing
    ;;"julia-cstparser"

    ;; Plantuml support
    "plantuml" ;; Draw UML diagrams from simple textual description

    ;; Python support
    "python-pytest" ;; Python testing library

    ))
  (packages->manifest (list
		       ;;ghc-hcg-minus
		       ;;ghc-hls



		       ;; Under test ;;;;

		       ;; TODO: repair
		       ;; Error message: 
		       ;;Too many heap sections: Increase MAXHINCR or MAX_HEAP_SECTS
		       ;;./bin/update_doom-emacs: line 8: 17409 Aborted                 "$GUIX_EXTRA/$PROJECT_NAME/guix/bin/guix" package --manifest=manifest.scm --profile="$GUIX_EXTRA_PROFILES/$PROJECT_NAME/$PROJECT_NAME"
		      ;;python-pipenv

		       ;;python-pyenv

		       ;;julia-languageserver
		       ;;julia-symbolserver
		       ))
  ))
