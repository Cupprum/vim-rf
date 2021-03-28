from robot.running import TestSuiteBuilder
from robot.model import SuiteVisitor
import sys


class TestCasesFinder(SuiteVisitor):
    def __init__(self):
        self.tests = []

    def visit_test(self, test):
        self.tests.append(test)


builder = TestSuiteBuilder()
testsuite = builder.build(str(sys.argv[1]))
finder = TestCasesFinder()
testsuite.visit(finder)

for test in finder.tests:
    print(test, end="\n\n")
