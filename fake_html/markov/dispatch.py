from functools import lru_cache

from .construct import DataCollector


@lru_cache()
def _global_model():
    dc = DataCollector()
    dc.add_local_dataset()
    return dc.to_model()


def fake_html(seed: int = None) -> str:
    return _global_model().fake_html(seed=seed)
