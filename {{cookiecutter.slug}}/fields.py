def _inject_globals():
    from yaml import safe_load
    from stepup.core.api import amend
    if amend(inp="fields.yaml"):
        with open("fields.yaml") as fh:
            fields = safe_load(fh)
        globals().update(fields)


_inject_globals()
