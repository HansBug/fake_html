import pytest

from fake_html.markov import HTMLMarkov, DataCollector


@pytest.fixture(scope='session')
def default_model() -> HTMLMarkov:
    dc = DataCollector()
    dc.add_local_dataset(recursive=True)
    return dc.to_model()
