from __future__ import annotations

from dataclasses import dataclass
from typing import Any, Dict, Optional

from django.conf import settings


@dataclass(frozen=True)
class Neo4jConfig:
    uri: str
    username: str
    password: str
    database: str


_driver = None


def _get_config() -> Neo4jConfig:
    uri = getattr(settings, 'NEO4J_URI', '')
    username = getattr(settings, 'NEO4J_USERNAME', '')
    password = getattr(settings, 'NEO4J_PASSWORD', '')
    database = getattr(settings, 'NEO4J_DATABASE', 'neo4j')

    if not uri or not username or not password:
        raise RuntimeError('Neo4j settings missing. Set NEO4J_URI, NEO4J_USERNAME, NEO4J_PASSWORD.')

    return Neo4jConfig(uri=uri, username=username, password=password, database=database)


def get_driver():
    global _driver
    if _driver is not None:
        return _driver

    try:
        from neo4j import GraphDatabase
    except Exception as e:
        raise RuntimeError('Neo4j driver not installed. Install package "neo4j".') from e

    cfg = _get_config()
    _driver = GraphDatabase.driver(cfg.uri, auth=(cfg.username, cfg.password))
    return _driver


def close_driver() -> None:
    global _driver
    if _driver is None:
        return
    _driver.close()
    _driver = None


def run_cypher(query: str, parameters: Optional[Dict[str, Any]] = None) -> Any:
    cfg = _get_config()
    driver = get_driver()
    with driver.session(database=cfg.database) as session:
        return session.run(query, parameters or {}).data()


def verify_connectivity() -> None:
    driver = get_driver()
    driver.verify_connectivity()
