
from collections import defaultdict
import regex
import sys

RULE_REGEX = regex.compile(r'(.*) bags contain (?:(no|\d+) (.*?) bags?(?:, )?)+\.')

def process_rules(rules):
    rules_dict = {}
    for rule in rules:
        m = regex.fullmatch(RULE_REGEX, rule)
        if m is None:
            raise ValueError(f"Couldn't parse rule: {rule!r}")
        colour = m.group(1)
        child_nums = m.captures(2)
        child_colours = m.captures(3)

        children = {}

        for n, c in zip(child_nums, child_colours):
            if n == 'no':
                continue
            children[c] = int(n)

        rules_dict[colour] = children

    return rules_dict

def parents_of(rules, colour):
    parents = set()
    for parent, children in rules.items():
        if colour in children:
            parents.add(parent)
            parents |= parents_of(rules, parent)
    return parents

def children_of(rules, colour):
    children = defaultdict(lambda: 0)
    for child_colour, child_num in rules[colour].items():
        children[child_colour] += child_num
        for col, num in children_of(rules, child_colour).items():
            children[col] += child_num * num
    return children

if __name__ == '__main__':
    bag_rules = [rule.strip() for rule in sys.stdin.readlines()]
    rules = process_rules(bag_rules)
    print(len(parents_of(rules, 'shiny gold')))
    print(sum(children_of(rules, 'shiny gold').values()))