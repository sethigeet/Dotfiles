from libqtile.config import Group

from .group_names import group_names

groups = [Group(name, **kwargs) for name, kwargs in group_names]
