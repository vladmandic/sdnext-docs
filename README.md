<img src="https://github.com/vladmandic/automatic/raw/master/html/logo-transparent.png" width=200 alt="SD.Next">

# SD.Next Documentation

Built using [MkDocs](https://www.mkdocs.org/) and [Material](https://squidfunk.github.io/mkdocs-material/)  

- Rebuild using `build.sh`  
- Run live server using `serve.sh`  
- GitHub action: `.github/workflows/mkdocs-action.yaml`  
  1. Runs `build.sh` every 4h
  2. Pulls latest [Wiki](https://github.com/vladmandic/automatic/wiki)
  3. Rebuilds docs
  4. Pushes the updates as needed
  5. Rebuilds [GH pages](https://vladmandic.github.io/sdnext-docs/)
