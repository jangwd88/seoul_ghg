import toMark from 'to-mark';
import domUtils from './domUtils';

/**
 * Check if given node is valid delimiter run.
 * According to common-mark spec, following examples are not valid delimiter runs.
 * 1. opening (*|**) preceded by an alphanumeric and followed by a punctuation.
 *    (ex: a**~~c~~b**)
 * 2. closing (*|**) preceded by a punctuation and followed by an alphanumeric.
 *    (ex: **b~~c~~**a)
 * @see {@link https://spec.commonmark.org/0.29/#delimiter-run}
 * @see {@link https://github.com/commonmark/commonmark-spec/issues/611#issuecomment-533578503}
 */
function isValidDelimiterRun(node) {
  const {isElemNode, isTextNode} = domUtils;
  const isInvalidOpener = isTextNode(node.previousSibling) && isElemNode(node.firstChild);
  const isInvalidCloser = isTextNode(node.nextSibling) && isElemNode(node.lastChild);

  return !isInvalidOpener && !isInvalidCloser;
}

function convertEmphasis(node, subContent, delimiter) {
  const FIND_BEFORE_AND_AFTER_SPACES_RX = /^(\s*)(\S|\S.*\S)(\s*)$/;
  const [, beforeSpaces, trimmedContent, afterSpaces] = subContent.match(FIND_BEFORE_AND_AFTER_SPACES_RX);

  let convertedContent;

  if (isValidDelimiterRun(node)) {
    convertedContent = `${delimiter}${trimmedContent}${delimiter}`;
  } else {
    const tagName = node.nodeName.toLowerCase();

    convertedContent = `<${tagName}>${trimmedContent}</${tagName}>`;
  }

  return `${beforeSpaces}${convertedContent}${afterSpaces}`;
}

export default toMark.Renderer.factory(toMark.gfmRenderer, {
  'EM, I': function(node, subContent) {
    if (this.isEmptyText(subContent)) {
      return '';
    }

    return convertEmphasis(node, subContent, '*');
  },
  'STRONG, B': function(node, subContent) {
    if (this.isEmptyText(subContent)) {
      return '';
    }

    return convertEmphasis(node, subContent, '**');
  },
  'DEL, S': function(node, subContent) {
    if (this.isEmptyText(subContent)) {
      return '';
    }

    return convertEmphasis(node, subContent, '~~');
  }
});
