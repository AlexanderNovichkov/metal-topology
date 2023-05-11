#import <XCTest/XCTest.h>

#import <Metal/Metal.h>

#import "SparseMatrixReduction.h"
#import "utils.h"

@interface SparseMatrixReductionTest : XCTestCase

@end

@implementation SparseMatrixReductionTest{
    id<MTLDevice> _mDevice;
}

- (void)setUp {
    _mDevice = MTLCreateSystemDefaultDevice();
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testMatrix1Reduction {
    SparseMatrix *matrix = [self readMatrixFromFile:@"matrix_1.txt"];
    SparseMatrixReduction* reduction = [[SparseMatrixReduction alloc] initWithDevice:_mDevice Matrix:matrix];
    SparseMatrix *reducedMatrix = [reduction makeReduction];
    SparseMatrix *expectedReducedMatrix = [self readMatrixFromFile:@"matrix_1_reduced.txt"];
    XCTAssertEqualObjects([reducedMatrix description], [expectedReducedMatrix description]);
}

- (void)testMatrix2Reduction {
    SparseMatrix *matrix = [self readMatrixFromFile:@"matrix_2.txt"];
    SparseMatrixReduction* reduction = [[SparseMatrixReduction alloc] initWithDevice:_mDevice Matrix:matrix];
    SparseMatrix *reducedMatrix = [reduction makeReduction];
    SparseMatrix *expectedReducedMatrix = [self readMatrixFromFile:@"matrix_2_reduced.txt"];
    XCTAssertEqualObjects([reducedMatrix description], [expectedReducedMatrix description]);
}

- (void)testMatrix3PersistencePairs {
    SparseMatrix *matrix = [self readMatrixFromFile:@"matrix_3.txt"];
    SparseMatrixReduction* reduction = [[SparseMatrixReduction alloc] initWithDevice:_mDevice Matrix:matrix];
    [reduction makeReduction];
    PersistencePairs *pairs = [reduction getPersistentPairs];
    PersistencePairs *expectedPairs = [self readPersistencePairsFromFile:@"matrix_3_pairs.txt"];
    XCTAssertEqualObjects([pairs description], [expectedPairs description]);
}

- (void)testMatrixHivPersistencePairs {
    SparseMatrix *matrix = [self readMatrixFromFile:@"matrix_hiv_14_610.0.txt"];
    SparseMatrixReduction* reduction = [[SparseMatrixReduction alloc] initWithDevice:_mDevice Matrix:matrix];
    [reduction makeReduction];
    PersistencePairs *pairs = [reduction getPersistentPairs];
    PersistencePairs *expectedPairs = [self readPersistencePairsFromFile:@"matrix_hiv_14_610.0_pairs.txt"];
    XCTAssertEqualObjects([pairs description], [expectedPairs description]);
}

- (void)testMatrixh3n2PersistencePairs {
    SparseMatrix *matrix = [self readMatrixFromFile:@"matrix_h3n2_2_30.0.txt"];
    SparseMatrixReduction* reduction = [[SparseMatrixReduction alloc] initWithDevice:_mDevice Matrix:matrix];
    [reduction makeReduction];
    PersistencePairs *pairs = [reduction getPersistentPairs];
    PersistencePairs *expectedPairs = [self readPersistencePairsFromFile:@"matrix_h3n2_2_30.0_pairs.txt"];
    XCTAssertEqualObjects([pairs description], [expectedPairs description]);
}

- (SparseMatrix*) readMatrixFromFile: (NSString*) filename {
    NSBundle *bundle = [NSBundle bundleForClass: [self class]];
    NSString * path = [[bundle URLForResource:filename withExtension: nil] path];
    SparseMatrix *matrix =  [[SparseMatrix alloc] initWithDevice:_mDevice FromFile:path];
    assert(matrix != nil);
    return matrix;
}

- (PersistencePairs*) readPersistencePairsFromFile: (NSString*) filename {
    NSBundle *bundle = [NSBundle bundleForClass: [self class]];
    NSString * path = [[bundle URLForResource:filename withExtension: nil] path];
    PersistencePairs*pairs = [[PersistencePairs alloc] initFromFile:path];
    assert(pairs != nil);
    return pairs;
}

@end
