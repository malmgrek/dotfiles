"""This works with the develop branch of powerline

See https://github.com/powerline/powerline/issues/1953
"""
try:
    from powerline.bindings.ipython.since_7 import PowerlinePrompts
    c = get_config()
    c.TerminalInteractiveShell.simple_prompt = False
    c.TerminalInteractiveShell.prompts_class = PowerlinePrompts
except Exception as err:
    pass
