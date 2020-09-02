# Leaving passthrough mode conflicts with Jupyter Vim plugin
config.unbind("<Shift-Escape>", mode="passthrough")
config.bind("<Ctrl-Shift-Escape>", "leave-mode", mode="passthrough")
