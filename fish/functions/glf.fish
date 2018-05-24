function glf
	git log --graph --pretty=format:'%Cred%h%Creset %an -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative
end
