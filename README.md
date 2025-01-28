### Overviews:

### Note:
Git create a new branch and switch to current `git checkout -b my-branch` & `git branch -l` to list all branches.......

### Git Branch Management Workflow:
- `git log`, `git status` and `git diff` to get a overview of the current repo on this directory 
- `git branch`
- `git checkout -b <new-branch-name>` will create a new branch as specified and will checkout all-together. Then do `git add .` > `git commit ...` > `git push -u origin <branch-name>` to update the remote.
- `git checkout <existing-branch-name>` to select the current branch as working branch.
- next learn more about `pulling from a specific branch` && more on this https://stackoverflow.com/questions/4924002/git-pulling-from-specific-branch
- next merging and conflict resolution workflows

### Temp 

```swift
 private lazy var dummyBtn: UIButton = {
        let uiButton = UIButton()
        uiButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        uiButton.tintColor = .white
        return uiButton
    }()
    
    private lazy var dummyBtn2: UIButton = {
        let uiButton = UIButton()
        uiButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        uiButton.tintColor = .white
        return uiButton
    }()
    
    private lazy var dummyBtn3: UIButton = {
        let uiButton = UIButton()
        uiButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        uiButton.tintColor = .white
        return uiButton
    }()
    
    private lazy var dummyBtn4: UIButton = {
        let uiButton = UIButton()
        uiButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        uiButton.tintColor = .white
        uiButton.backgroundColor = .yellow
        return uiButton
    }()
    
    private lazy var dummyBtn5: UIButton = {
        let uiButton = UIButton()
        uiButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        uiButton.tintColor = .white
        return uiButton
    }()
```